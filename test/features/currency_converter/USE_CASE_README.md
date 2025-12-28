# 🎯 Use Case Tests - `use_case_test.dart`

## 🎯 إيه اللي بنختبره هنا؟

**الطبقة:** Domain Layer - Application Logic  
**الوظيفة:** اختبار Validation و Business Rules واستدعاء Repository

---

## 📋 التيستات (3 tests)

### ✅ Test 1: Happy Path - parameters صحيحة

**الهدف:** نتأكد ان الـ Use Case بيمرر الـ parameters صح للـ Repository لما تكون صحيحة

**المثال:**
```
Params: {from: "USD", to: "EGY"}
Repository رجع: Right(30.5)
المفروض Use Case يرجع: Right(30.5) ✅
```

**الكود:**
```dart
test('should return Right when parameters are valid', () async {
  // Arrange - نجهز parameters صحيحة
  const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
  
  // نخلي الـ mock repository يرجع Right(30.5)
  when(() => mockRepository.convertCurrency('USD', 'EGY'))
      .thenAnswer((_) async => const Right(30.5));

  // Act - نستدعي الـ Use Case
  final result = await useCase.call(params);

  // Assert - المفروض يرجع Right(30.5)
  expect(result, const Right(30.5));
});
```

**الشرح:**
- الـ parameters صحيحة (from و to مليانين)
- الـ Use Case بيمررهم للـ Repository
- الـ Repository رجع `Right(30.5)`
- الـ Use Case بيمرر النتيجة زي ما هي

---

### 🛡️ Test 2: Validation - from فاضي

**الهدف:** نتأكد ان الـ Use Case بيعمل validation قبل ما يستدعي الـ Repository

**المثال:**
```
Params: {from: "", to: "EGY"}  // from فاضي! ❌
المفروض Use Case يرجع: Left(ServerFailure("Invalid parameters"))
ومايستدعيش Repository أصلاً
```

**الكود:**
```dart
test('should return error when from is empty', () async {
  // Arrange - parameters غلط (from فاضي)
  const params = ConvertCurrencyParams(from: '', to: 'EGY');

  // Act - نستدعي الـ Use Case
  final result = await useCase.call(params);

  // Assert - المفروض يرجع Left مع رسالة error
  expect(result, const Left(ServerFailure('Invalid parameters')));
  
  // مهم جداً: نتأكد ان Repository مااتستدعاش أصلاً
  verifyNever(() => mockRepository.convertCurrency(any(), any()));
});
```

**الشرح:**
- الـ `from` فاضي (`''`)
- الـ Use Case بيشوف ده في الأول (validation)
- بيرجع `Left(ServerFailure("Invalid parameters"))` مباشرة
- **مش بيستدعي Repository أصلاً** (ده مهم علشان efficiency)

**الكود الحقيقي:**
```dart
Future<Either<Failure, double>> call([ConvertCurrencyParams? params]) async {
  // Validation أول حاجة
  if (params!.from.isEmpty || params.to.isEmpty) {
    return const Left(ServerFailure('Invalid parameters'));
  }

  // لو validation نجح، بس كده نستدعي Repository
  return repository.convertCurrency(params.from, params.to);
}
```

---

### ❌ Test 3: Repository فشل - يمرر الـ error

**الهدف:** نتأكد ان الـ Use Case بيمرر الـ error من Repository زي ما هي

**المثال:**
```
Params: {from: "USD", to: "EGY"}
Repository رجع: Left(ServerFailure("Network error"))
المفروض Use Case يرجع: Left(ServerFailure("Network error")) ❌
```

**الكود:**
```dart
test('should pass through error from repository', () async {
  // Arrange - parameters صحيحة
  const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
  
  // نخلي الـ mock repository يرجع Left (failure)
  when(() => mockRepository.convertCurrency('USD', 'EGY'))
      .thenAnswer((_) async => const Left(ServerFailure('Network error')));

  // Act - نستدعي الـ Use Case
  final result = await useCase.call(params);

  // Assert - المفروض يرجع نفس الـ error
  expect(result, const Left(ServerFailure('Network error')));
});
```

**الشرح:**
- الـ parameters صحيحة (validation نجح)
- الـ Use Case استدعى Repository
- Repository رجع `Left(ServerFailure("Network error"))`
- الـ Use Case بيمرر الـ error زي ما هي (مش بيعدل عليها)

---

## 🔍 المفاهيم المستخدمة

### 1. Validation (التحقق)
```dart
if (params.from.isEmpty || params.to.isEmpty) {
  return const Left(ServerFailure('Invalid parameters'));
}
```

**ليه مهم؟**
- علشان نتأكد من الـ input قبل ما نروح للـ Repository
- علشان نوفر API calls غير ضرورية
- علشان نرجع error واضح للمستخدم

### 2. ConvertCurrencyParams
```dart
const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
```

**ليه بنستخدم object مش parameters منفصلة؟**
- علشان الكود يكون أنظف
- علشان parameters تكون grouped مع بعض
- علشان سهل نضيف parameters جديدة

### 3. verifyNever()
```dart
verifyNever(() => mockRepository.convertCurrency(any(), any()));
```

**ليه مهم؟**
- نتأكد ان Repository مااتستدعاش لو validation فشل
- ده مهم علشان efficiency (مافيش API calls غير ضرورية)

---

## 🏗️ Architecture Context

```
┌─────────────────────────────────────┐
│     Repository Layer                │
│  (repository_test.dart)             │
│  يرجع: Either<Failure, double>      │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│     Use Case Layer                  │ ← إحنا هنا!
│  (use_case_test.dart)               │
│                                     │
│  - بيعمل Validation                 │
│  - بيستخدم Repository               │
│  - بيرجع Either<Failure, double>    │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│         Cubit Layer                 │
│  (cubit_test.dart)                  │
└─────────────────────────────────────┘
```

**الـ Use Case:**
- Business Logic Layer
- بيعمل validation للـ input
- بيستخدم Repository علشان يجيب البيانات
- بيربط بين Presentation Layer و Domain Layer

---

## 💡 لماذا هذه التيستات مهمة؟

### 1. Input Validation ✅
- نتأكد ان الـ Use Case بيشيك الـ parameters قبل ما يستدعي Repository
- نتأكد ان الـ error messages واضحة

### 2. Business Logic ✅
- نتأكد ان الـ Use Case بيطبق الـ business rules صح
- نتأكد ان الـ flow صحيح

### 3. Integration ✅
- نتأكد ان الـ Use Case بيستخدم Repository صح
- نتأكد ان الـ errors بتعدي من Repository للـ Use Case صح

---

## 🔄 الـ Flow الكامل

### Success Flow:
```
1. Use Case يستقبل params: {from: "USD", to: "EGY"}
2. Use Case يعمل validation → ✅ صحيحة
3. Use Case يستدعي Repository
4. Repository يرجع Right(30.5)
5. Use Case يرجع Right(30.5) ✅
```

### Validation Failure Flow:
```
1. Use Case يستقبل params: {from: "", to: "EGY"}
2. Use Case يعمل validation → ❌ from فاضي
3. Use Case بيرجع Left("Invalid parameters") مباشرة
4. Repository مااتستدعاش أصلاً ✅
```

### Repository Failure Flow:
```
1. Use Case يستقبل params: {from: "USD", to: "EGY"}
2. Use Case يعمل validation → ✅ صحيحة
3. Use Case يستدعي Repository
4. Repository يرجع Left("Network error")
5. Use Case يمرر Left("Network error") زي ما هي ✅
```

---

## 🎓 كيف تفهم التيستات؟

### الخطوة 1: شوف الـ Mock
```dart
late MockCurrencyConverterRepository mockRepository;
```
- نسخة وهمية من Repository
- بنستخدمها علشان نتحكم في النتايج

### الخطوة 2: شوف Validation Test
```dart
const params = ConvertCurrencyParams(from: '', to: 'EGY');
```
- parameters غلط (from فاضي)
- الـ Use Case المفروض يرجع error مباشرة

### الخطوة 3: شوف Success Test
```dart
const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
when(() => mockRepository.convertCurrency(...))
    .thenAnswer((_) async => const Right(30.5));
```
- parameters صحيحة
- Repository رجع Right(30.5)
- الـ Use Case بيمرر النتيجة

### الخطوة 4: شوف Error Propagation Test
```dart
when(() => mockRepository.convertCurrency(...))
    .thenAnswer((_) async => const Left(ServerFailure('Network error')));
```
- Repository رجع Left
- الـ Use Case بيمرر الـ error زي ما هي

---

## 🚀 طريقة التشغيل

```bash
# تشغيل التيستات دي بس
flutter test test/features/currency_converter/use_case_test.dart
```

**النتيجة المتوقعة:**
```
✅ 3 tests passed
```

---

## 📊 Coverage

| السيناريو | مختبر؟ | الوصف |
|-----------|--------|-------|
| ✅ Parameters صحيحة | ✅ نعم | Right(rate) |
| 🛡️ from فاضي | ✅ نعم | Left("Invalid parameters") |
| ❌ Repository فشل | ✅ نعم | يمرر error |

---

## 🔄 العلاقة مع التيستات التانية

### Repository → Use Case → Cubit
```dart
// 1. Repository يرجع: Either<Failure, double>
// 2. Use Case يعمل validation + يستخدم Repository
// 3. Cubit يستخدم Use Case علشان يجيب البيانات
```

### الـ Flow:
```
Repository (Either<Failure, double>)
    ↓
Use Case (validation + Either<Failure, double>)
    ↓
Cubit (State Management)
```

---

## ❓ أسئلة شائعة

### ليه بنعمل validation في Use Case مش في Repository؟
- علشان الـ Use Case هو اللي عنده business rules
- علشان نمنع API calls غير ضرورية
- علشان الـ validation يكون في مكان واحد

### ليه بنستخدم verifyNever()؟
- علشان نتأكد ان Repository مااتستدعاش لو validation فشل
- ده مهم علشان efficiency
- ده جزء من الـ test quality

### ليه الـ Use Case بيمرر error من Repository زي ما هي؟
- علشان الـ Use Case مش مسؤول عن تعديل الـ errors
- علشان الـ error messages تكون من Repository (اللي بيتكلم مع الـ API)
- علشان separation of concerns

---

## ✨ الخلاصة

**الـ Use Case Tests:**
- ✅ بتختبر validation (مهم جداً!)
- ✅ بتختبر integration مع Repository
- ✅ بتختبر business logic
- ✅ أساسية لفهم الـ Clean Architecture

**الخطوة التالية:**
بعد ما تفهم الـ Use Case، اقرأ `CUBIT_README.md` علشان تفهم إزاي الـ Cubit بيستخدم الـ Use Case! 🚀

---

تم بحمد الله! ❤️

