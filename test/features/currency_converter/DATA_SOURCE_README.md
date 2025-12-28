# 📡 Data Source Tests - `data_source_test.dart`

## 🎯 إيه اللي بنختبره هنا؟

**الطبقة:** Data Layer - API Integration  
**الوظيفة:** اختبار التعامل مع الـ API واستخراج الـ rate من الـ response

---

## 📋 التيستات (2 tests)

### ✅ Test 1: Happy Path - يرجع rate صحيح

**الهدف:** نتأكد ان الدالة بترجع الـ rate صح لما الـ API يرجع response صحيحة

**المثال:**
```
الـ API رجع: {"result": {"EGY": 30.5}}
المفروض الدالة ترجع: 30.5 ✅
```

**الكود:**
```dart
test('should return rate when API succeeds', () async {
  // Arrange - نجهز fake response من الـ API
  final fakeResponse = {
    'result': {'EGY': 30.5}  // الـ rate اللي هنرجع
  };
  
  // نقول للـ mock API: لما حد يطلبك، ارجع الـ fake response
  when(() => mockApiService.get(
        endpoint: Endpoint.convertCurrency,
        parameter: '&from=USD&to=EGY',
      )).thenAnswer((_) async => fakeResponse);

  // Act - نستدعي الدالة اللي عاوزين نختبرها
  final result = await dataSource.convertCurrency('USD', 'EGY');

  // Assert - نتأكد ان النتيجة صح
  expect(result, 30.5);  // المفروض تكون 30.5
});
```

**الشرح:**
1. **Arrange:** نجهز fake response (زي ما الـ API الحقيقي بيرجع)
2. **Act:** نستدعي `convertCurrency` 
3. **Assert:** نتأكد ان الـ result = 30.5

---

### ❌ Test 2: Error Case - rate يكون null

**الهدف:** نتأكد ان الدالة بترمي exception لما الـ rate يكون null

**المثال:**
```
الـ API رجع: {"result": {"EGY": null}}
المفروض الدالة ترمي: ServerException ❌
```

**الكود:**
```dart
test('should throw exception when rate is null', () async {
  // Arrange - fake response فيها rate = null
  final fakeResponse = {
    'result': {'EGY': null}  // null! ❌
  };
  
  when(() => mockApiService.get(
        endpoint: Endpoint.convertCurrency,
        parameter: '&from=USD&to=EGY',
      )).thenAnswer((_) async => fakeResponse);

  // Act & Assert - نتوقع ان الدالة ترمي exception
  expect(
    () => dataSource.convertCurrency('USD', 'EGY'),
    throwsA(isA<ServerException>()),  // المفروض ترمي ServerException
  );
});
```

**الشرح:**
- لما الـ API يرجع `null` في الـ rate، الدالة المفروض ترمي `ServerException`
- ده علشان نمنع استخدام rate غير صحيح في الكود

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
  () => dataSource.convertCurrency(...),
  throwsA(isA<ServerException>()),
);
```

**الشرح:**
- نتوقع ان الدالة ترمي exception من نوع `ServerException`

---

## 🏗️ Architecture Context

```
┌─────────────────────────────────────┐
│     CurrencyConverterDataSource     │ ← إحنا هنا!
│  (data_source_test.dart)           │
│                                     │
│  - بيتكلم مع الـ API مباشرة        │
│  - بستخرج الـ rate من response     │
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
- بتحول الـ API response لـ format مناسب

---

## 💡 لماذا هذه التيستات مهمة؟

### 1. API Integration ✅
- نتأكد ان الـ API call بيحصل صح
- نتأكد ان الـ response بيتم parsing صح

### 2. Error Handling ✅
- نتأكد ان الدالة بتتعامل مع الـ null values صح
- نتأكد ان الـ exceptions بتطلع في الوقت المناسب

### 3. Data Extraction ✅
- نتأكد ان الـ rate بيتستخرج من الـ response صح
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
final fakeResponse = {'result': {'EGY': 30.5}};
when(() => mockApiService.get(...)).thenAnswer(...);
```
- بنجهز الـ fake response
- بنقول للـ mock: ارجع الـ response ده

### الخطوة 3: شوف الـ Act
```dart
final result = await dataSource.convertCurrency('USD', 'EGY');
```
- نستدعي الدالة اللي عاوزين نختبرها

### الخطوة 4: شوف الـ Assert
```dart
expect(result, 30.5);
```
- نتأكد من النتيجة

---

## 🚀 طريقة التشغيل

```bash
# تشغيل التيستات دي بس
flutter test test/features/currency_converter/data_source_test.dart
```

**النتيجة المتوقعة:**
```
✅ 2 tests passed
```

---

## 📊 Coverage

| السيناريو | مختبر؟ | الوصف |
|-----------|--------|-------|
| ✅ API نجح | ✅ نعم | يرجع rate صحيح |
| ❌ rate = null | ✅ نعم | يرمي exception |

---

## 🔄 العلاقة مع التيستات التانية

### Data Source → Repository
```dart
// Data Source يرجع: double أو Exception
// Repository يستخدم Data Source ويحول Exception → Failure
```

### الـ Flow:
```
1. Data Source → يرجع rate (double)
2. Repository → يستقبل rate أو exception
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

### ليه في تيستين بس؟
- لأنهما يغطيان الحالات الأساسية:
  - ✅ Success (كل حاجة تمام)
  - ❌ Error (في مشكلة)

---

## ✨ الخلاصة

**الـ Data Source Tests:**
- ✅ بسيطة ومباشرة (2 tests فقط)
- ✅ بتختبر API integration
- ✅ بتختبر error handling
- ✅ أساسية لفهم باقي التيستات

**الخطوة التالية:**
بعد ما تفهم الـ Data Source، اقرأ `REPOSITORY_README.md` علشان تفهم إزاي الـ Repository بيستخدم الـ Data Source! 🚀

---

تم بحمد الله! ❤️

