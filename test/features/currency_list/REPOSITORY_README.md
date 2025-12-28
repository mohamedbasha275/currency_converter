# 🔄 Repository Tests - `repository_test.dart`

## 🎯 إيه اللي بنختبره هنا؟

**الطبقة:** Domain Layer - Business Logic  
**الوظيفة:** اختبار معالجة الأخطاء وتحويل Exceptions إلى Failures + Refresh Logic

---

## 📋 التيستات (5 tests)

### ✅ Test 1: getCurrencies - Happy Path

**الهدف:** نتأكد ان الـ Repository بيمرر الـ currencies من الـ Data Source بنجاح

**المثال:**
```
Data Source رجع: [CurrencyListEntity, CurrencyListEntity]
المفروض Repository يرجع: Right([CurrencyListEntity, CurrencyListEntity]) ✅
```

**الكود:**
```dart
test('should return Right when data source succeeds', () async {
  // Arrange - نخلي الـ mock data source يرجع currencies
  final fakeCurrencies = [
    const CurrencyListEntity(code: 'USD', name: 'US Dollar', ...),
    const CurrencyListEntity(code: 'EGY', name: 'Egyptian Pound', ...),
  ];

  when(() => mockDataSource.getCurrencies())
      .thenAnswer((_) async => fakeCurrencies);

  // Act - نستدعي الـ Repository
  final result = await repository.getCurrencies();

  // Assert - المفروض يرجع Right(currencies)
  expect(result, Right(fakeCurrencies));
});
```

**الشرح:**
- الـ Data Source نجح ورجع list of currencies
- الـ Repository بيحطها في `Right(fakeCurrencies)` (يعني نجح ✅)

---

### ❌ Test 2: getCurrencies - ServerException → ServerFailure

**الهدف:** نتأكد ان الـ Repository بيحول ServerException إلى ServerFailure

**المثال:**
```
Data Source رمى: ServerException("Error")
المفروض Repository يرجع: Left(ServerFailure("Error")) ❌
```

**الكود:**
```dart
test('should return Left when ServerException occurs', () async {
  // Arrange - نخلي الـ mock data source يرمي ServerException
  when(() => mockDataSource.getCurrencies())
      .thenThrow(const ServerException('Error'));

  // Act - نستدعي الـ Repository
  final result = await repository.getCurrencies();

  // Assert - المفروض يرجع Left
  expect(result.isLeft(), true);
});
```

---

### ❌ Test 3: getCurrencies - Network Error → ServerFailure

**الهدف:** نتأكد ان الـ Repository بيتعامل مع مشاكل الشبكة صح

**المثال:**
```
Data Source رمى: DioException (connectionError)
المفروض Repository يرجع: Left(ServerFailure("No internet...")) ❌
```

**الكود:**
```dart
test('should return Left when no internet connection', () async {
  // Arrange - نخلي الـ mock يرمي DioException
  final dioError = DioException(
    requestOptions: RequestOptions(),
    type: DioExceptionType.connectionError,
  );
  when(() => mockDataSource.getCurrencies()).thenThrow(dioError);

  // Act - نستدعي الـ Repository
  final result = await repository.getCurrencies();

  // Assert - المفروض يرجع Left
  expect(result.isLeft(), true);
});
```

---

### ✅ Test 4: refreshCurrencies - Happy Path

**الهدف:** نتأكد ان الـ refresh بيشتغل صح

**المثال:**
```
1. Data Source بيمسح cache
2. Data Source بيرجع currencies جديدة
المفروض Repository يرجع: Right(currencies) ✅
```

**الكود:**
```dart
test('should return Right when refresh succeeds', () async {
  // Arrange
  final fakeCurrencies = [
    const CurrencyListEntity(code: 'USD', name: 'US Dollar', ...),
  ];

  // نخلي الـ mock data source يمسح cache
  when(() => mockDataSource.clearLocalCache())
      .thenAnswer((_) async => {});
  
  // نخلي الـ mock data source يرجع currencies جديدة
  when(() => mockDataSource.getCurrencies())
      .thenAnswer((_) async => fakeCurrencies);

  // Act - نستدعي refresh
  final result = await repository.refreshCurrencies();

  // Assert - المفروض يرجع Right
  expect(result, Right(fakeCurrencies));
  
  // نتأكد ان الـ cache اتمسح والـ currencies اتباعت
  verify(() => mockDataSource.clearLocalCache()).called(1);
  verify(() => mockDataSource.getCurrencies()).called(1);
});
```

**الشرح:**
- `refreshCurrencies` بيعمل:
  1. يمسح الـ cache (`clearLocalCache`)
  2. يجيب currencies جديدة من API (`getCurrencies`)
  3. يرجعها في `Right(currencies)`

---

### ❌ Test 5: refreshCurrencies - Error Case

**الهدف:** نتأكد ان الـ refresh بيشغل error handling صح

**المثال:**
```
1. Data Source بيمسح cache (نجح ✅)
2. Data Source بيرمي ServerException (فشل ❌)
المفروض Repository يرجع: Left(ServerFailure) ❌
```

**الكود:**
```dart
test('should return Left when refresh fails', () async {
  // Arrange
  when(() => mockDataSource.clearLocalCache())
      .thenAnswer((_) async => {});  // مسح cache نجح
  when(() => mockDataSource.getCurrencies())
      .thenThrow(const ServerException('Error'));  // جلب currencies فشل

  // Act - نستدعي refresh
  final result = await repository.refreshCurrencies();

  // Assert - المفروض يرجع Left
  expect(result.isLeft(), true);
});
```

---

## 🔍 المفاهيم المستخدمة

### 1. Either<Failure, List<CurrencyListEntity>>
```dart
Either<Failure, List<CurrencyListEntity>>
```

**الشرح:**
- نوع بيانات بيحتوي على واحد من اثنين:
  - `Right(currencies)`: نجح ✅ - فيه list of currencies
  - `Left(failure)`: فشل ❌ - فيه error

### 2. safeApiCall()
```dart
return safeApiCall(() => dataSource.getCurrencies());
```

**الشرح:**
- Function بتعمل try-catch للـ API call
- لو نجح → ترجع `Right(result)`
- لو فشل → ترجع `Left(failure)`

### 3. refreshCurrencies Implementation
```dart
Future<Either<Failure, List<CurrencyListEntity>>> refreshCurrencies() async {
  return safeApiCall(() async {
    await dataSource.clearLocalCache();  // امسح cache
    return await dataSource.getCurrencies();  // اجيب currencies جديدة
  });
}
```

**الشرح:**
- بيمسح الـ cache الأول
- بعدين بيجيب currencies جديدة من API
- كل ده داخل `safeApiCall` علشان error handling

---

## 🏗️ Architecture Context

```
┌─────────────────────────────────────┐
│     Data Source Layer               │
│  (data_source_test.dart)            │
│  يرجع: List<CurrencyListEntity> أو Exception
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│     Repository Layer                │ ← إحنا هنا!
│  (repository_test.dart)             │
│                                     │
│  - بيستقبل List أو Exception        │
│  - بيحول Exception → Failure        │
│  - بيرجع Either<Failure, List>      │
│  - بيدير refresh logic              │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│         Use Case Layer              │
│  (use_case_test.dart)               │
└─────────────────────────────────────┘
```

**الـ Repository:**
- الليلة اللي بين الـ Data Layer و Domain Layer
- مسؤولة عن تحويل Exceptions إلى Failures
- بيدير refresh logic (مسح cache + جلب بيانات جديدة)

---

## 💡 لماذا هذه التيستات مهمة؟

### 1. Error Handling ✅
- نتأكد ان الـ Exceptions بتتحول لـ Failures صح
- نتأكد ان الـ error messages واضحة

### 2. Refresh Logic ✅
- نتأكد ان `refreshCurrencies` شغالة صح
- نتأكد ان الـ cache بيتمسح قبل refresh
- نتأكد ان الـ error handling شغال في refresh

### 3. Type Safety ✅
- نتأكد ان الـ return type صحيح: `Either<Failure, List<CurrencyListEntity>>`
- نتأكد ان الـ Success cases ترجع `Right`
- نتأكد ان الـ Error cases ترجع `Left`

---

## 🔄 الفرق بين getCurrencies و refreshCurrencies

### getCurrencies
```dart
// يستخدم cache لو موجود
// يرجع Either<Failure, List<CurrencyListEntity>>
```

**السلوك:**
1. يتأكد من وجود cache
2. لو في cache → يرجع من cache
3. لو مفيش cache → يجيب من API ويحفظ في cache

### refreshCurrencies
```dart
// بيمسح cache الأول
// بعدين بيجيب من API
// يرجع Either<Failure, List<CurrencyListEntity>>
```

**السلوك:**
1. يمسح الـ cache
2. يجيب currencies جديدة من API
3. يحفظ في cache (عبر getCurrencies)
4. يرجع الـ currencies

---

## 🎓 كيف تفهم التيستات؟

### الخطوة 1: شوف الـ Mock
```dart
late MockCurrencyListDataSource mockDataSource;
```
- نسخة وهمية من الـ Data Source

### الخطوة 2: شوف الـ Arrange (Success Case)
```dart
when(() => mockDataSource.getCurrencies())
    .thenAnswer((_) async => fakeCurrencies);
```
- نخلي الـ Data Source يرجع currencies
- الـ Repository المفروض يحطها في `Right(currencies)`

### الخطوة 3: شوف الـ Arrange (Error Case)
```dart
when(() => mockDataSource.getCurrencies())
    .thenThrow(const ServerException('Error'));
```
- نخلي الـ Data Source يرمي Exception
- الـ Repository المفروض يحولها لـ `Left(ServerFailure)`

### الخطوة 4: شوف الـ Arrange (Refresh Case)
```dart
when(() => mockDataSource.clearLocalCache()).thenAnswer(...);
when(() => mockDataSource.getCurrencies()).thenAnswer(...);
```
- نخلي الـ Data Source يمسح cache ويرجع currencies
- الـ Repository المفروض يرجع `Right(currencies)`

---

## 🚀 طريقة التشغيل

```bash
# تشغيل التيستات دي بس
flutter test test/features/currency_list/repository_test.dart
```

**النتيجة المتوقعة:**
```
✅ 5 tests passed
```

---

## 📊 Coverage

| السيناريو | مختبر؟ | الوصف |
|-----------|--------|-------|
| ✅ getCurrencies نجح | ✅ نعم | Right(currencies) |
| ❌ getCurrencies: ServerException | ✅ نعم | Left(ServerFailure) |
| ❌ getCurrencies: Network Error | ✅ نعم | Left(ServerFailure) |
| ✅ refreshCurrencies نجح | ✅ نعم | Right(currencies) |
| ❌ refreshCurrencies فشل | ✅ نعم | Left(ServerFailure) |

---

## 🔄 العلاقة مع التيستات التانية

### Data Source → Repository → Use Case
```dart
// 1. Data Source يرجع: List أو Exception
// 2. Repository يحول: Exception → Left(Failure)
// 3. Use Case يستقبل: Either<Failure, List>
```

### الـ Flow:
```
Data Source (List/Exception)
    ↓
Repository (Either<Failure, List>)
    ↓
Use Case (Either<Failure, List>)
```

---

## ❓ أسئلة شائعة

### ليه في function اسمها refreshCurrencies؟
- علشان المستخدم يقدر يجيب بيانات جديدة من الـ API
- علشان يمسح الـ cache القديم ويحل محله بيانات جديدة
- علشان يعمل pull-to-refresh في الـ UI

### إيه الفرق بين getCurrencies و refreshCurrencies في الـ Repository؟
- **getCurrencies**: بيمرر call للـ Data Source (اللي بيدير cache logic)
- **refreshCurrencies**: بيمسح cache وبعدين بيعمل getCurrencies (للحصول على بيانات جديدة)

### ليه بنستخدم Either مش Exception؟
- علشان type-safe
- علشان سهل نمرر errors بين الطبقات
- علشان الكود يكون أوضح

---

## ✨ الخلاصة

**الـ Repository Tests:**
- ✅ بتختبر error handling
- ✅ بتختبر type safety (Either)
- ✅ بتختبر refresh logic
- ✅ بتختبر integration مع Data Source
- ✅ أساسية لفهم الـ Clean Architecture

**الخطوة التالية:**
بعد ما تفهم الـ Repository، اقرأ `USE_CASE_README.md` علشان تفهم إزاي الـ Use Case بيستخدم الـ Repository! 🚀

---

تم بحمد الله! ❤️

