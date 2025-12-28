# 📡 Data Source Tests - `data_source_test.dart`

## 🎯 إيه اللي بنختبره هنا؟

**الطبقة:** Data Layer - API Integration  
**الوظيفة:** اختبار جلب الأسعار التاريخية من API واستخراجها من response

---

## 📋 التيستات (3 tests)

### ✅ Test 1: Happy Path - API يرجع rates صحيحة

**الهدف:** نتأكد ان الدالة بترجع الـ historical rates صح لما الـ API يرجع response صحيحة

**المثال:**
```
الـ API رجع: {"results": {"USD": {"2024-01-01": 30.5, "2024-01-02": 30.7}}}
المفروض الدالة ترجع: [HistoricalRateModel(rate: 30.5, date: 2024-01-01), ...] ✅
```

**الكود:**
```dart
test('should return rates when API succeeds', () async {
  // Arrange - نجهز fake response من الـ API
  final fakeResponse = {
    'results': {
      'USD': {
        '2024-01-01': 30.5,
        '2024-01-02': 30.7,
      }
    }
  };

  // نقول للـ mock API: لما حد يطلبك، ارجع الـ fake response
  when(() => mockApiService.get(
        endpoint: Endpoint.getCurrenciesHistory,
        parameter: any(named: 'parameter'),
      )).thenAnswer((_) async => fakeResponse);

  // Act - نستدعي الدالة اللي عاوزين نختبرها
  final result = await dataSource.getHistoricalRates('USD', 'EGY');

  // Assert - نتأكد ان النتيجة صح
  expect(result.length, 2);
  expect(result.first.rate, 30.5);
});
```

**الشرح:**
1. **Arrange:** نجهز fake response (زي ما الـ API الحقيقي بيرجع)
2. **Act:** نستدعي `getHistoricalRates` 
3. **Assert:** نتأكد ان الـ rates رجعت صح (عددها 2، والـ rate الأول 30.5)

---

### ❌ Test 2: Error Case - results فاضية

**الهدف:** نتأكد ان الدالة بترمي exception لما الـ results تكون فاضية

**المثال:**
```
الـ API رجع: {}  (فاضي!)
المفروض الدالة ترمي: ServerException ❌
```

**الكود:**
```dart
test('should throw exception when results are empty', () async {
  // Arrange - fake response فاضي
  final fakeResponse = <String, dynamic>{};

  when(() => mockApiService.get(
        endpoint: Endpoint.getCurrenciesHistory,
        parameter: any(named: 'parameter'),
      )).thenAnswer((_) async => fakeResponse);

  // Act & Assert - نتوقع ان الدالة ترمي exception
  expect(
    () => dataSource.getHistoricalRates('USD', 'EGY'),
    throwsA(isA<ServerException>()),
  );
});
```

**الشرح:**
- لما الـ API يرجع response فاضي (مفيش `results` key)، الدالة المفروض ترمي `ServerException`
- ده علشان نمنع استخدام data غير صحيح في الكود

---

### ❌ Test 3: Error Case - rates list فاضية

**الهدف:** نتأكد ان الدالة بترمي exception لما الـ rates list تكون فاضية

**المثال:**
```
الـ API رجع: {"results": {}}  (results موجودة لكن فاضية!)
المفروض الدالة ترمي: ServerException ❌
```

**الكود:**
```dart
test('should throw exception when rates list is empty', () async {
  // Arrange - fake response فيه results لكن فاضية
  final fakeResponse = {
    'results': <String, dynamic>{}  // results موجودة لكن فاضية!
  };

  when(() => mockApiService.get(
        endpoint: Endpoint.getCurrenciesHistory,
        parameter: any(named: 'parameter'),
      )).thenAnswer((_) async => fakeResponse);

  // Act & Assert - نتوقع ان الدالة ترمي exception
  expect(
    () => dataSource.getHistoricalRates('USD', 'EGY'),
    throwsA(isA<ServerException>()),
  );
});
```

**الشرح:**
- لما الـ API يرجع `results` لكن فاضية (مفيش rates داخل)، الدالة المفروض ترمي `ServerException`
- ده علشان نتأكد ان في بيانات فعلية راجعة من الـ API

---

## 🔍 المفاهيم المستخدمة

### 1. Mock (النسخة الوهمية)
```dart
class MockApiService extends Mock implements ApiService {}
```

**ليه بنستخدمه؟**
- علشان مانطلبش من الـ API الحقيقي في التيستات
- علشان نتحكم في الـ response ونجرب scenarios مختلفة
- علشان التيستات تكون سريعة (مافيش network calls)

### 2. when().thenAnswer()
```dart
when(() => mockApiService.get(...))
    .thenAnswer((_) async => fakeResponse);
```

**الشرح:**
- `when`: لما حد يستدعي الـ method دي
- `thenAnswer`: ارجع الـ fake response ده

### 3. expect().throwsA()
```dart
expect(
  () => dataSource.getHistoricalRates(...),
  throwsA(isA<ServerException>()),
);
```

**الشرح:**
- نتوقع ان الدالة ترمي exception من نوع `ServerException`

### 4. Historical Rates API Response Format
```dart
{
  'results': {
    'USD': {           // Currency code
      '2024-01-01': 30.5,  // Date: Rate
      '2024-01-02': 30.7,
    }
  }
}
```

**الشرح:**
- الـ API بيرجع nested map structure
- بنحتاج نستخرج الـ rates وتحولها لـ `List<HistoricalRateModel>`

---

## 🏗️ Architecture Context

```
┌─────────────────────────────────────┐
│     HistoricalRatesDataSource       │ ← إحنا هنا!
│  (data_source_test.dart)           │
│                                     │
│  - بيتكلم مع الـ API مباشرة        │
│  - بستخرج الـ rates من response    │
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
- مسؤولة عن التواصل مع الـ API
- بتحول الـ API response (nested map) لـ `List<HistoricalRateModel>`

---

## 💡 لماذا هذه التيستات مهمة؟

### 1. API Integration ✅
- نتأكد ان الـ API call بيحصل صح
- نتأكد ان الـ response بيتم parsing صح
- نتأكد ان الـ nested structure بيتعامل معاها صح

### 2. Error Handling ✅
- نتأكد ان الدالة بتتعامل مع الـ empty responses صح
- نتأكد ان الـ exceptions بتطلع في الوقت المناسب
- نتأكد ان الـ validation موجودة

### 3. Data Extraction ✅
- نتأكد ان الـ rates بتستخرج من الـ response صح
- نتأكد ان الـ dates و rates صح
- نتأكد ان الـ data format صحيح

---

## 🎓 كيف تفهم التيستات؟

### الخطوة 1: شوف الـ Mock
```dart
late MockApiService mockApiService;
```
- ده نسخة وهمية من الـ API
- بنستخدمها علشان نتحكم في الـ responses

### الخطوة 2: شوف الـ Arrange
```dart
final fakeResponse = {
  'results': {
    'USD': {
      '2024-01-01': 30.5,
      '2024-01-02': 30.7,
    }
  }
};
when(() => mockApiService.get(...)).thenAnswer(...);
```
- بنجهز الـ fake response (nested structure)
- بنقول للـ mock: ارجع الـ response ده

### الخطوة 3: شوف الـ Act
```dart
final result = await dataSource.getHistoricalRates('USD', 'EGY');
```
- نستدعي الدالة اللي عاوزين نختبرها
- بنمرر currency codes (from و to)

### الخطوة 4: شوف الـ Assert
```dart
expect(result.length, 2);  // نتأكد من العدد
expect(result.first.rate, 30.5);  // نتأكد من الـ rate
```

---

## 🚀 طريقة التشغيل

```bash
# تشغيل التيستات دي بس
flutter test test/features/historical_rates/data_source_test.dart
```

**النتيجة المتوقعة:**
```
✅ 3 tests passed
```

---

## 📊 Coverage

| السيناريو | مختبر؟ | الوصف |
|-----------|--------|-------|
| ✅ API نجح | ✅ نعم | يرجع rates صحيحة |
| ❌ results = null | ✅ نعم | يرمي exception |
| ❌ results فاضية | ✅ نعم | يرمي exception |

---

## 🔄 العلاقة مع التيستات التانية

### Data Source → Repository
```dart
// Data Source يرجع: List<HistoricalRateModel> أو Exception
// Repository يستخدم Data Source ويحول Exception → Failure
```

### الـ Flow:
```
1. Data Source → يرجع rates (List) أو Exception
2. Repository → يستقبل rates أو exception
3. Repository → يحول exception → Left(ServerFailure)
```

---

## ❓ أسئلة شائعة

### ليه بنختبر الـ Data Source لوحدها؟
- علشان نعزل الـ API call
- علشان نتأكد ان الـ parsing صح
- علشان نختبر error cases منفصلة

### ليه بنستخدم Mock مش الـ API الحقيقي؟
- علشان التيستات تكون سريعة
- علشان مانحتاجش internet
- علشان نتحكم في الـ responses

### ليه في 3 تيستات؟
- علشان نغطي الحالات الأساسية:
  - ✅ Success (كل حاجة تمام)
  - ❌ Error (results فاضية)
  - ❌ Error (rates list فاضية)

### إيه الـ format اللي الـ API بيرجعه؟
```dart
{
  'results': {
    'BASE_CURRENCY': {
      'YYYY-MM-DD': rate_value,
      'YYYY-MM-DD': rate_value,
      ...
    }
  }
}
```
- nested map structure
- بنحتاج نستخرج كل date و rate وتحولها لـ `HistoricalRateModel`

---

## ✨ الخلاصة

**الـ Data Source Tests:**
- ✅ بسيطة ومباشرة (3 tests)
- ✅ بتختبر API integration
- ✅ بتختبر error handling
- ✅ بتختبر data extraction من nested structure
- ✅ أساسية لفهم باقي التيستات

**الخطوة التالية:**
بعد ما تفهم الـ Data Source، اقرأ `REPOSITORY_README.md` علشان تفهم إزاي الـ Repository بيستخدم الـ Data Source! 🚀

---

تم بحمد الله! ❤️

