# 🔄 Repository Tests - `repository_test.dart`

## 🎯 إيه اللي بنختبره هنا؟

**الطبقة:** Domain Layer - Business Logic  
**الوظيفة:** اختبار معالجة الأخطاء وتحويل Exceptions إلى Failures

---

## 📋 التيستات (3 tests)

### ✅ Test 1: Happy Path - data source نجح

**الهدف:** نتأكد ان الـ Repository بيمرر الـ rate من الـ Data Source بنجاح

**المثال:**
```
Data Source رجع: 30.5
المفروض Repository يرجع: Right(30.5) ✅
```

**الكود:**
```dart
test('should return Right when data source succeeds', () async {
  // Arrange - نخلي الـ mock data source يرجع rate صحيح
  when(() => mockDataSource.convertCurrency('USD', 'EGY'))
      .thenAnswer((_) async => 30.5);  // Data Source يرجع 30.5

  // Act - نستدعي الـ Repository
  final result = await repository.convertCurrency('USD', 'EGY');

  // Assert - المفروض يرجع Right(30.5)
  expect(result, const Right(30.5));
});
```

**الشرح:**
- الـ Data Source نجح ورجع `30.5`
- الـ Repository بيحطها في `Right(30.5)` (يعني نجح ✅)
- الـ `Right` من `Either` type - معناه success

---

### ❌ Test 2: ServerException → ServerFailure

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
  when(() => mockDataSource.convertCurrency('USD', 'EGY'))
      .thenThrow(const ServerException('Error'));  // Exception! ❌

  // Act - نستدعي الـ Repository
  final result = await repository.convertCurrency('USD', 'EGY');

  // Assert - المفروض يرجع Left (يعني failure)
  expect(result.isLeft(), true);  // isLeft() = true يعني في error
});
```

**الشرح:**
- الـ Data Source رمى `ServerException`
- الـ Repository بيحولها لـ `Left(ServerFailure)` (يعني فشل ❌)
- الـ `Left` من `Either` type - معناه failure

---

### ❌ Test 3: Network Error → ServerFailure

**الهدف:** نتأكد ان الـ Repository بيتعامل مع مشاكل الشبكة صح

**المثال:**
```
Data Source رمى: DioException (connectionError)
المفروض Repository يرجع: Left(ServerFailure("No internet...")) ❌
```

**الكود:**
```dart
test('should return Left when no internet connection', () async {
  // Arrange - نخلي الـ mock يرمي DioException (مشكلة شبكة)
  final dioError = DioException(
    requestOptions: RequestOptions(),
    type: DioExceptionType.connectionError,  // مفيش نت! ❌
  );
  when(() => mockDataSource.convertCurrency('USD', 'EGY'))
      .thenThrow(dioError);

  // Act - نستدعي الـ Repository
  final result = await repository.convertCurrency('USD', 'EGY');

  // Assert - المفروض يرجع Left
  expect(result.isLeft(), true);  // failure بسبب مفيش نت
});
```

**الشرح:**
- الـ Data Source رمى `DioException` (مشكلة شبكة)
- الـ Repository بيحولها لـ `Left(ServerFailure)` مع رسالة مناسبة
- الـ `safeApiCall` function اللي في الكود بتتعامل مع الـ DioException وتحوله لـ Failure

---

## 🔍 المفاهيم المستخدمة

### 1. Either<Failure, Data>
```dart
Either<Failure, double>
```

**الشرح:**
- نوع بيانات بيحتوي على واحد من اثنين:
  - `Right(data)`: نجح ✅ - فيه data
  - `Left(failure)`: فشل ❌ - فيه error

**مثال:**
```dart
// Success
Right(30.5)  // ✅ نجح، الـ rate = 30.5

// Failure
Left(ServerFailure('Error'))  // ❌ فشل، الرسالة = "Error"
```

### 2. safeApiCall()
```dart
return safeApiCall(() => dataSource.convertCurrency(from, to));
```

**الشرح:**
- Function بتعمل try-catch للـ API call
- لو نجح → ترجع `Right(result)`
- لو فشل → ترجع `Left(failure)`

**الكود الحقيقي:**
```dart
Future<Either<Failure, T>> safeApiCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);  // نجح ✅
  } catch (e) {
    if (e is DioException) {
      return Left(ServerFailure.fromDioError(e));  // فشل ❌
    }
    return Left(ServerFailure(e.toString()));
  }
}
```

### 3. isLeft() و isRight()
```dart
result.isLeft()   // true لو في error
result.isRight()  // true لو نجح
```

---

## 🏗️ Architecture Context

```
┌─────────────────────────────────────┐
│     Data Source Layer               │
│  (data_source_test.dart)            │
│  يرجع: double أو Exception          │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│     Repository Layer                │ ← إحنا هنا!
│  (repository_test.dart)             │
│                                     │
│  - بيستقبل double أو Exception      │
│  - بيحول Exception → Failure        │
│  - بيرجع Either<Failure, double>    │
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
- بتستخدم `safeApiCall` علشان تعمل error handling

---

## 💡 لماذا هذه التيستات مهمة؟

### 1. Error Handling ✅
- نتأكد ان الـ Exceptions بتتحول لـ Failures صح
- نتأكد ان الـ error messages واضحة

### 2. Type Safety ✅
- نتأكد ان الـ return type صحيح: `Either<Failure, double>`
- نتأكد ان الـ Success cases ترجع `Right`
- نتأكد ان الـ Error cases ترجع `Left`

### 3. Integration ✅
- نتأكد ان الـ Repository بيستخدم الـ Data Source صح
- نتأكد ان الـ errors بتعدي من Data Source للـ Repository صح

---

## 🔄 الفرق بين Exception و Failure

### Exception (في Data Source)
```dart
// Data Source يرجع Exception
throw ServerException('Error');
```

**المشكلة:**
- Exception لازم نتعامل معها بـ try-catch
- مش type-safe
- صعب نمررها بين الطبقات

### Failure (في Repository)
```dart
// Repository يرجع Failure
return Left(ServerFailure('Error'));
```

**المميزات:**
- Type-safe (جزء من return type)
- سهل نمررها بين الطبقات
- واضحة ومعبرة

---

## 🎓 كيف تفهم التيستات؟

### الخطوة 1: شوف الـ Mock
```dart
late MockCurrencyConverterDataSource mockDataSource;
```
- نسخة وهمية من الـ Data Source
- بنستخدمها علشان نتحكم في النتايج

### الخطوة 2: شوف الـ Arrange (Success Case)
```dart
when(() => mockDataSource.convertCurrency('USD', 'EGY'))
    .thenAnswer((_) async => 30.5);
```
- نخلي الـ Data Source يرجع rate صحيح
- الـ Repository المفروض يحطها في `Right(30.5)`

### الخطوة 3: شوف الـ Arrange (Error Case)
```dart
when(() => mockDataSource.convertCurrency('USD', 'EGY'))
    .thenThrow(const ServerException('Error'));
```
- نخلي الـ Data Source يرمي Exception
- الـ Repository المفروض يحولها لـ `Left(ServerFailure)`

### الخطوة 4: شوف الـ Assert
```dart
expect(result, const Right(30.5));  // Success
expect(result.isLeft(), true);      // Failure
```

---

## 🚀 طريقة التشغيل

```bash
# تشغيل التيستات دي بس
flutter test test/features/currency_converter/repository_test.dart
```

**النتيجة المتوقعة:**
```
✅ 3 tests passed
```

---

## 📊 Coverage

| السيناريو | مختبر؟ | الوصف |
|-----------|--------|-------|
| ✅ Data Source نجح | ✅ نعم | Right(rate) |
| ❌ ServerException | ✅ نعم | Left(ServerFailure) |
| ❌ Network Error | ✅ نعم | Left(ServerFailure) |

---

## 🔄 العلاقة مع التيستات التانية

### Data Source → Repository → Use Case
```dart
// 1. Data Source يرجع: double أو Exception
// 2. Repository يحول: Exception → Left(Failure)
// 3. Use Case يستقبل: Either<Failure, double>
```

### الـ Flow:
```
Data Source (double/Exception)
    ↓
Repository (Either<Failure, double>)
    ↓
Use Case (Either<Failure, double>)
```

---

## ❓ أسئلة شائعة

### ليه بنستخدم Either مش Exception؟
- علشان type-safe
- علشان سهل نمرر errors بين الطبقات
- علشان الكود يكون أوضح

### إيه الفرق بين ServerException و ServerFailure؟
- **ServerException**: Exception في Data Layer
- **ServerFailure**: Failure في Domain Layer
- الـ Repository بيحول Exception → Failure

### ليه في 3 تيستات بس؟
- علشان نغطي الحالات الأساسية:
  - ✅ Success
  - ❌ ServerException
  - ❌ Network Error

---

## ✨ الخلاصة

**الـ Repository Tests:**
- ✅ بتختبر error handling
- ✅ بتختبر type safety (Either)
- ✅ بتختبر integration مع Data Source
- ✅ أساسية لفهم الـ Clean Architecture

**الخطوة التالية:**
بعد ما تفهم الـ Repository، اقرأ `USE_CASE_README.md` علشان تفهم إزاي الـ Use Case بيستخدم الـ Repository! 🚀

---

تم بحمد الله! ❤️

