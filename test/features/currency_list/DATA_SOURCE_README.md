# 📡 Data Source Tests - `data_source_test.dart`

## 🎯 إيه اللي بنختبره هنا؟

**الطبقة:** Data Layer - API Integration & Cache  
**الوظيفة:** اختبار جلب قائمة العملات من API أو من Cache

---

## 📋 التيستات (3 tests)

### ✅ Test 1: Happy Path - يرجع currencies من API (مفيش cache)

**الهدف:** نتأكد ان الدالة بترجع الـ currencies من API لما مفيش cache

**المثال:**
```
الـ API رجع: {"currencies": {"USD": "US Dollar", "EGY": "Egyptian Pound"}}
المفروض الدالة ترجع: [CurrencyListEntity, CurrencyListEntity] ✅
```

**الكود:**
```dart
test('should return currencies from API when no cache', () async {
  // Arrange - نجهز fake response من الـ API
  final fakeResponse = {
    'currencies': {
      'USD': 'US Dollar',
      'EGY': 'Egyptian Pound',
    }
  };

  // نخلي الـ mock database يقول: مفيش cache
  when(() => mockDatabaseHelper.hasCurrencies())
      .thenAnswer((_) async => false); // مفيش cache
  
  // نقول للـ mock API: ارجع الـ fake response
  when(() => mockApiService.get(endpoint: Endpoint.getCurrencies))
      .thenAnswer((_) async => fakeResponse);
  
  // نخلي الـ mock database يحفظ الـ currencies
  when(() => mockDatabaseHelper.insertCurrencies(any()))
      .thenAnswer((_) async => {});

  // Act - نستدعي الدالة
  final result = await dataSource.getCurrencies();

  // Assert - نتأكد ان النتيجة صح
  expect(result.length, 2);
  expect(result.any((c) => c.code == 'USD'), true);
  expect(result.any((c) => c.code == 'EGY'), true);
});
```

**الشرح:**
1. **Arrange:** 
   - نخلي الـ database يقول: مفيش cache (`hasCurrencies` = false)
   - نجهز fake response من API
   - نخلي الـ database يحفظ الـ currencies بعد ما نجيبها
2. **Act:** نستدعي `getCurrencies` 
3. **Assert:** نتأكد ان الـ currencies رجعت صح

---

### ✅ Test 2: Cache - يرجع currencies من cache

**الهدف:** نتأكد ان الدالة بترجع الـ currencies من cache لما موجودة

**المثال:**
```
الـ Cache فيه: [CurrencyListEntity(code: 'USD', ...)]
المفروض الدالة ترجع: [CurrencyListEntity] ✅
(وما تستدعيش الـ API خالص)
```

**الكود:**
```dart
test('should return currencies from cache when available', () async {
  // Arrange - نجهز cached currencies
  final cachedCurrencies = [
    CurrencyListModel.fromJson({
      'code': 'USD',
      'name': 'US Dollar',
      'symbol': '\$',
      'flagUrl': 'https://flagcdn.com/us.png',
    }),
  ];

  // نخلي الـ mock database يقول: في cache
  when(() => mockDatabaseHelper.hasCurrencies())
      .thenAnswer((_) async => true); // في cache
  
  // نخلي الـ mock database يرجع الـ cached currencies
  when(() => mockDatabaseHelper.getCurrencies())
      .thenAnswer((_) async => cachedCurrencies);

  // Act - نستدعي الدالة
  final result = await dataSource.getCurrencies();

  // Assert - نتأكد ان النتيجة من cache
  expect(result.length, 1);
  expect(result.first.code, 'USD');
  // نتأكد ان الـ API ما اتستدعتش (لأن في cache)
});
```

**الشرح:**
- لما في cache موجود، الدالة ترجع الـ currencies من cache مباشرة
- الـ API call ما بيحصلش خالص (لذلك الـ performance أحسن)

---

### ✅ Test 3: clearLocalCache - يمسح الـ cache

**الهدف:** نتأكد ان الدالة بتمسح الـ cache

**الكود:**
```dart
test('should clear local cache', () async {
  // Arrange
  when(() => mockDatabaseHelper.clearCurrencies())
      .thenAnswer((_) async => Future.value());

  // Act - نستدعي الدالة
  await dataSource.clearLocalCache();

  // Assert - نتأكد ان الـ database تم استدعاؤه
  verify(() => mockDatabaseHelper.clearCurrencies()).called(1);
});
```

**الشرح:**
- الدالة بتستدعي `clearCurrencies` من الـ database helper
- ده بيحصل لما المستخدم يعمل refresh للقائمة

---

## 🔍 المفاهيم المستخدمة

### 1. Cache Strategy
```dart
if (hasCached) {
  return cachedCurrencies;  // استخدم cache
} else {
  final response = await apiService.get(...);  // استخدم API
  await databaseHelper.insertCurrencies(...);  // احفظ في cache
  return currencies;
}
```

**ليه بنستخدم Cache؟**
- علشان نسرع الـ loading (مافيش network calls)
- علشان نعمل offline support
- علشان نقلل الـ API calls

### 2. Database Helper
```dart
class CurrencyDatabaseHelper {
  Future<bool> hasCurrencies();      // في cache؟
  Future<List<CurrencyListEntity>> getCurrencies();  // اجيب من cache
  Future<void> insertCurrencies(...);  // احفظ في cache
  Future<void> clearCurrencies();      // امسح cache
}
```

**الوظيفة:**
- بيدير الـ local database (SQLite)
- بتحفظ الـ currencies محلياً
- بتوفر methods للتحقق والحفظ والمسح

### 3. Mock Multiple Dependencies
```dart
class MockApiService extends Mock implements ApiService {}
class MockCurrencyDatabaseHelper extends Mock implements CurrencyDatabaseHelper {}
```

**الشرح:**
- الـ Data Source محتاج dependency واحدة (ApiService) + dependency واحدة (DatabaseHelper)
- بنعمل mock لكل واحد فيهم علشان نتحكم في سلوكهم

---

## 🏗️ Architecture Context

```
┌─────────────────────────────────────┐
│     CurrencyListDataSource          │ ← إحنا هنا!
│  (data_source_test.dart)           │
│                                     │
│  - بيتكلم مع API أو Cache          │
│  - بيدير الـ caching strategy      │
│  - بيرمي exceptions للأخطاء        │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│         Repository Layer            │
│  (repository_test.dart)             │
└─────────────────────────────────────┘
```

**الـ Data Source:**
- أول طبقة في الـ Clean Architecture
- مسؤولة عن API integration + caching
- بتحول الـ API response لـ `List<CurrencyListEntity>`

---

## 💡 لماذا هذه التيستات مهمة؟

### 1. Cache Logic ✅
- نتأكد ان الـ cache strategy شغالة صح
- نتأكد ان الـ API call ما بيحصلش لما في cache
- نتأكد ان الـ currencies بتتحفظ في cache بعد API call

### 2. API Integration ✅
- نتأكد ان الـ API call بيحصل صح
- نتأكد ان الـ response بيتم parsing صح
- نتأكد ان الـ data format صحيح

### 3. Cache Management ✅
- نتأكد ان `clearLocalCache` شغالة صح
- نتأكد ان الـ cache بيتحكم فيه صح

---

## 🎓 كيف تفهم التيستات؟

### الخطوة 1: شوف الـ Mocks
```dart
late MockApiService mockApiService;
late MockCurrencyDatabaseHelper mockDatabaseHelper;
```
- نسختين وهميتين: واحدة للـ API، واحدة للـ Database

### الخطوة 2: شوف الـ Arrange (No Cache Case)
```dart
when(() => mockDatabaseHelper.hasCurrencies()).thenAnswer((_) async => false);
when(() => mockApiService.get(...)).thenAnswer((_) async => fakeResponse);
```
- نخلي الـ database يقول: مفيش cache
- نخلي الـ API يرجع fake response

### الخطوة 3: شوف الـ Arrange (Cache Case)
```dart
when(() => mockDatabaseHelper.hasCurrencies()).thenAnswer((_) async => true);
when(() => mockDatabaseHelper.getCurrencies()).thenAnswer((_) async => cachedCurrencies);
```
- نخلي الـ database يقول: في cache
- نخلي الـ database يرجع cached currencies

### الخطوة 4: شوف الـ Assert
```dart
expect(result.length, 2);  // نتأكد من العدد
expect(result.any((c) => c.code == 'USD'), true);  // نتأكد من المحتوى
```

---

## 🚀 طريقة التشغيل

```bash
# تشغيل التيستات دي بس
flutter test test/features/currency_list/data_source_test.dart
```

**النتيجة المتوقعة:**
```
✅ 3 tests passed
```

---

## 📊 Coverage

| السيناريو | مختبر؟ | الوصف |
|-----------|--------|-------|
| ✅ API (no cache) | ✅ نعم | يرجع currencies من API |
| ✅ Cache available | ✅ نعم | يرجع currencies من cache |
| ✅ Clear cache | ✅ نعم | يمسح الـ cache |

---

## 🔄 العلاقة مع التيستات التانية

### Data Source → Repository
```dart
// Data Source يرجع: List<CurrencyListEntity> أو Exception
// Repository يستخدم Data Source ويحول Exception → Failure
```

### الـ Flow:
```
1. Data Source → يرجع currencies (List) أو Exception
2. Repository → يستقبل currencies أو exception
3. Repository → يحول exception → Left(ServerFailure)
```

---

## ❓ أسئلة شائعة

### ليه في cache strategy؟
- علشان نسرع الـ app (مافيش network calls كل مرة)
- علشان نعمل offline support
- علشان نقلل الـ API calls (تحسين الأداء)

### إيه الفرق بين getCurrencies و refreshCurrencies؟
- **getCurrencies**: بيستخدم cache لو موجود، وإلا بيدور على API
- **refreshCurrencies**: بيمسح cache وبيدور على API مباشرة (للحصول على بيانات جديدة)

### ليه بنستخدم Mock للـ Database Helper؟
- علشان التيستات تكون سريعة (مافيش database operations حقيقية)
- علشان نتحكم في الـ cache state
- علشان نختبر scenarios مختلفة (cache موجود/مفيش cache)

---

## ✨ الخلاصة

**الـ Data Source Tests:**
- ✅ بسيطة ومباشرة (3 tests)
- ✅ بتختبر API integration + caching
- ✅ بتختبر cache management
- ✅ أساسية لفهم الـ caching strategy

**الخطوة التالية:**
بعد ما تفهم الـ Data Source، اقرأ `REPOSITORY_README.md` علشان تفهم إزاي الـ Repository بيستخدم الـ Data Source! 🚀

---

تم بحمد الله! ❤️

