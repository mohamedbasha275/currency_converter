# 🎭 Cubit Tests - `cubit_test.dart`

## 🎯 إيه اللي بنختبره هنا؟

**الطبقة:** Presentation Layer - UI Logic  
**الوظيفة:** اختبار State Management وربط UI بالـ Use Cases

---

## 📋 التيستات (9 tests)

### 🎬 Group 1: Initial State (1 test)

#### Test 1: يبدأ بـ Initial state

**الهدف:** نتأكد ان الـ Cubit بيبدأ بـ state صحيح

**الكود:**
```dart
test('should start with Initial state', () {
  expect(cubit.state, isA<CurrencyConverterInitial>());
});
```

**الشرح:**
- لما نعمل `CurrencyConverterCubit` جديد
- الـ state الأولي بيكون `CurrencyConverterInitial`
- ده الـ default state

---

### 🔄 Group 2: convertCurrency (3 tests)

#### Test 1: Success - Loading → Loaded

**الهدف:** نتأكد ان الـ states بتطلع صح لما التحويل ينجح

**المثال:**
```
Use Case رجع: Right(30.5)
المفروض States: Loading → Loaded(rate: 30.5) ✅
```

**الكود:**
```dart
blocTest<CurrencyConverterCubit, CurrencyConverterState>(
  'should emit Loading then Loaded on success',
  build: () {
    // نجهز الـ Cubit بالعملات
    cubit.setFromCurrency(usdCurrency);
    cubit.setToCurrency(egyPurrency);
    
    // نخلي الـ mock use case يرجع Right(30.5)
    when(() => mockUseCase.call(any()))
        .thenAnswer((_) async => const Right(30.5));
    return cubit;
  },
  act: (cubit) => cubit.convertCurrency(),  // نستدعي convertCurrency
  expect: () => [
    isA<CurrencyConverterLoading>(),  // 1. Loading أولاً
    isA<CurrencyConverterLoaded>()    // 2. Loaded بعدين
        .having((s) => s.rate, 'rate', 30.5),  // والـ rate = 30.5
  ],
);
```

**الشرح:**
- `build`: نجهز الـ Cubit ونضبط الـ mock
- `act`: نستدعي `convertCurrency()`
- `expect`: نتوقع states بالترتيب ده:
  1. `CurrencyConverterLoading` (بيظهر loading indicator)
  2. `CurrencyConverterLoaded` (مع الـ rate = 30.5)

**الـ UI هتستخدم الـ states دي:**
```dart
BlocBuilder<CurrencyConverterCubit, CurrencyConverterState>(
  builder: (context, state) {
    if (state is CurrencyConverterLoading) {
      return CircularProgressIndicator();  // Loading...
    }
    if (state is CurrencyConverterLoaded) {
      return Text('Rate: ${state.rate}');  // Rate: 30.5
    }
    return Container();
  },
)
```

---

#### Test 2: Error - Loading → Error

**الهدف:** نتأكد ان الـ states بتطلع صح لما التحويل يفشل

**المثال:**
```
Use Case رجع: Left(ServerFailure("Network error"))
المفروض States: Loading → Error(message: "Network error") ❌
```

**الكود:**
```dart
blocTest<CurrencyConverterCubit, CurrencyConverterState>(
  'should emit Loading then Error on failure',
  build: () {
    cubit.setFromCurrency(usdCurrency);
    cubit.setToCurrency(egyPurrency);
    
    // نخلي الـ mock use case يرجع Left (failure)
    when(() => mockUseCase.call(any()))
        .thenAnswer((_) async => const Left(ServerFailure('Network error')));
    return cubit;
  },
  act: (cubit) => cubit.convertCurrency(),
  expect: () => [
    isA<CurrencyConverterLoading>(),  // 1. Loading أولاً
    isA<CurrencyConverterError>()     // 2. Error بعدين
        .having((s) => s.message, 'message', 'Network error'),
  ],
);
```

**الشرح:**
- `CurrencyConverterLoading`: بيظهر loading indicator
- `CurrencyConverterError`: بيظهر error message للمستخدم

**الـ UI:**
```dart
if (state is CurrencyConverterError) {
  return Text('Error: ${state.message}');  // Error: Network error
}
```

---

#### Test 3: Calculation - يحسب converted amount

**الهدف:** نتأكد ان الـ Cubit بيحسب النتيجة النهائية صح

**المثال:**
```
amount = 100
rate = 30.5
المفروض: convertedAmount = 100 × 30.5 = 3050 ✅
```

**الكود:**
```dart
blocTest<CurrencyConverterCubit, CurrencyConverterState>(
  'should calculate converted amount correctly',
  build: () {
    cubit.setFromCurrency(usdCurrency);
    cubit.setToCurrency(egyPurrency);
    cubit.setAmount(100.0);  // 100 دولار
    when(() => mockUseCase.call(any()))
        .thenAnswer((_) async => const Right(30.5));  // rate = 30.5
    return cubit;
  },
  act: (cubit) => cubit.convertCurrency(),
  verify: (_) {
    expect(cubit.convertedAmount, 3050.0);  // 100 × 30.5 = 3050
  },
);
```

**الشرح:**
- `verify`: بعد ما التيست ينتهي، بنتحقق من values
- `convertedAmount`: getter بيحسب `amount × exchangeRate`
- الـ UI هتستخدم `cubit.convertedAmount` علشان تعرض النتيجة

---

### 🔄 Group 3: State Updates (3 tests)

#### Test 1: Update Currencies

**الهدف:** نتأكد ان تغيير العملات بيشتغل صح

**الكود:**
```dart
blocTest<CurrencyConverterCubit, CurrencyConverterState>(
  'should update currencies',
  build: () => cubit,
  act: (cubit) {
    cubit.setFromCurrency(usdCurrency);  // USD
    cubit.setToCurrency(egyPurrency);    // EGY
  },
  expect: () => [
    isA<CurrencyConverterUpdated>(),  // من setFromCurrency
    isA<CurrencyConverterUpdated>(),  // من setToCurrency
  ],
);
```

**الشرح:**
- `setFromCurrency`: بيغير عملة المصدر
- `setToCurrency`: بيغير عملة الهدف
- كل واحد فيهم بيرجع `CurrencyConverterUpdated` state
- الـ UI بتستخدم الـ state ده علشان تعيد build

---

#### Test 2: Update Amount

**الهدف:** نتأكد ان تغيير المبلغ بيشتغل صح

**الكود:**
```dart
blocTest<CurrencyConverterCubit, CurrencyConverterState>(
  'should update amount',
  build: () => cubit,
  act: (cubit) => cubit.setAmount(500.0),  // نغير المبلغ لـ 500
  verify: (_) {
    expect(cubit.amount, 500.0);  // نتأكد ان اتغيرت
  },
);
```

**الشرح:**
- `setAmount`: بيغير المبلغ
- `verify`: نتأكد ان `cubit.amount` = 500.0

---

#### Test 3: Swap Currencies

**الهدف:** نتأكد ان تبديل العملات بيشتغل صح

**المثال:**
```
قبل: USD → EGY
بعد: EGY → USD ✅
```

**الكود:**
```dart
blocTest<CurrencyConverterCubit, CurrencyConverterState>(
  'should swap currencies',
  build: () => cubit,
  seed: () {
    // نضبط الـ initial state بدون ما يطلع في expect
    cubit.fromCurrency = usdCurrency;
    cubit.toCurrency = egyPurrency;
    return CurrencyConverterInitial();
  },
  act: (cubit) => cubit.swapCurrencies(),  // تبديل
  verify: (_) {
    expect(cubit.fromCurrency?.code, 'EGY');  // اتبدلت!
    expect(cubit.toCurrency?.code, 'USD');    // اتبدلت!
  },
);
```

**الشرح:**
- `seed`: نضبط initial state (مش هيدخل في `expect`)
- `swapCurrencies`: ببدل بين fromCurrency و toCurrency
- `verify`: نتأكد انهم اتبدلوا

---

### 🧮 Group 4: convertedAmount Getter (2 tests)

#### Test 1: Calculation - amount × rate

**الهدف:** نتأكد ان الحساب صحيح

**الكود:**
```dart
test('should calculate amount times rate', () {
  cubit.amount = 100.0;        // 100 دولار
  cubit.exchangeRate = 30.5;   // rate = 30.5
  
  expect(cubit.convertedAmount, 3050.0);  // 100 × 30.5 = 3050
});
```

**الشرح:**
- `convertedAmount`: getter بيعمل `amount × exchangeRate`
- الـ UI بتستخدمه علشان تعرض النتيجة النهائية

---

#### Test 2: Null Check - rate = null

**الهدف:** نتأكد ان لو rate = null، يرجع 0

**الكود:**
```dart
test('should return 0 when rate is null', () {
  cubit.amount = 100.0;
  cubit.exchangeRate = null;  // null!
  
  expect(cubit.convertedAmount, 0.0);  // يرجع 0
});
```

**الشرح:**
- لو `exchangeRate` = null، المفروض يرجع 0
- ده علشان الـ UI ما تعرضش قيمة غلط

**الكود الحقيقي:**
```dart
double get convertedAmount {
  if (exchangeRate == null || amount == 0) return 0.0;
  return amount * exchangeRate!;
}
```

---

## 🔍 المفاهيم المستخدمة

### 1. blocTest()
```dart
blocTest<CubitType, StateType>(
  'description',
  build: () => cubit,     // نجهز الـ Cubit
  act: (cubit) => ...,    // نستدعي method
  expect: () => [...],    // الـ states المتوقعة
  verify: (_) => ...,     // (optional) فحوصات إضافية
);
```

**الشرح:**
- من `bloc_test` package
- مخصوص لاختبار BLoC/Cubit
- بيساعدنا نختبر states

### 2. States Flow
```
Initial → Updated → Loading → Loaded/Error
```

**الشرح:**
- `Initial`: الـ state الأولي
- `Updated`: لما بنغير حاجة (عملات، مبلغ)
- `Loading`: لما بنستنى النتيجة
- `Loaded`: لما النتيجة توصل بنجاح
- `Error`: لما في error

### 3. seed vs build
```dart
build: () => cubit,  // ينشئ الـ Cubit
seed: () => initialState,  // يضبط initial state (مش هيدخل في expect)
```

**الفرق:**
- `build`: ينشئ الـ Cubit (الـ states اللي بتيجي من build هتدخل في `expect`)
- `seed`: يضبط initial state (مش هيدخل في `expect`)

---

## 🏗️ Architecture Context

```
┌─────────────────────────────────────┐
│     Use Case Layer                  │
│  (use_case_test.dart)               │
│  يرجع: Either<Failure, double>      │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│     Cubit Layer                     │ ← إحنا هنا!
│  (cubit_test.dart)                  │
│                                     │
│  - State Management                 │
│  - يستخدم Use Case                 │
│  - بيربط UI بالـ Business Logic    │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│         UI Layer                    │
│  (Widgets, Screens)                 │
└─────────────────────────────────────┘
```

**الـ Cubit:**
- Presentation Layer
- مسؤول عن State Management
- بيستخدم Use Cases علشان يجيب البيانات
- بيربط بين UI و Business Logic

---

## 💡 لماذا هذه التيستات مهمة؟

### 1. State Management ✅
- نتأكد ان الـ states بتطلع بالترتيب الصحيح
- نتأكد ان الـ UI بتستقبل states صحيحة

### 2. UI Integration ✅
- نتأكد ان الـ Cubit بيعمل اللي الـ UI محتاجاه
- نتأكد ان الـ calculations صحيحة

### 3. Use Case Integration ✅
- نتأكد ان الـ Cubit بيستخدم Use Cases صح
- نتأكد ان الـ errors بتعدي من Use Case للـ Cubit صح

---

## 🎓 كيف تفهم التيستات؟

### الخطوة 1: شوف الـ Mock
```dart
late MockConvertCurrencyUseCase mockUseCase;
```
- نسخة وهمية من Use Case
- بنستخدمها علشان نتحكم في النتايج

### الخطوة 2: شوف Success Test
```dart
when(() => mockUseCase.call(any()))
    .thenAnswer((_) async => const Right(30.5));
```
- Use Case يرجع Right(30.5)
- الـ Cubit المفروض يطلع Loading → Loaded

### الخطوة 3: شوف Error Test
```dart
when(() => mockUseCase.call(any()))
    .thenAnswer((_) async => const Left(ServerFailure('Network error')));
```
- Use Case يرجع Left
- الـ Cubit المفروض يطلع Loading → Error

### الخطوة 4: شوف States في expect
```dart
expect: () => [
  isA<CurrencyConverterLoading>(),
  isA<CurrencyConverterLoaded>(),
],
```
- الـ states بالترتيب اللي المفروض تطلع

---

## 🚀 طريقة التشغيل

```bash
# تشغيل التيستات دي بس
flutter test test/features/currency_converter/cubit_test.dart
```

**النتيجة المتوقعة:**
```
✅ 9 tests passed
```

---

## 📊 Coverage

| السيناريو | مختبر؟ | الوصف |
|-----------|--------|-------|
| 🎬 Initial State | ✅ نعم | CurrencyConverterInitial |
| ✅ Success | ✅ نعم | Loading → Loaded |
| ❌ Error | ✅ نعم | Loading → Error |
| 🧮 Calculation | ✅ نعم | amount × rate |
| 🔄 Update Currencies | ✅ نعم | setFromCurrency, setToCurrency |
| 🔄 Update Amount | ✅ نعم | setAmount |
| 🔁 Swap | ✅ نعم | swapCurrencies |
| 🧮 Getter (calculation) | ✅ نعم | amount × rate |
| 🧮 Getter (null) | ✅ نعم | rate = null → 0 |

---

## 🔄 العلاقة مع التيستات التانية

### Use Case → Cubit → UI
```dart
// 1. Use Case يرجع: Either<Failure, double>
// 2. Cubit يستخدم Use Case وبيطلع States
// 3. UI تستخدم States علشان تعرض البيانات
```

### الـ Flow الكامل:
```
Use Case (Either<Failure, double>)
    ↓
Cubit (States: Loading → Loaded/Error)
    ↓
UI (Widgets تعرض البيانات)
```

---

## ❓ أسئلة شائعة

### ليه بنستخدم blocTest مش test عادي؟
- علشان `blocTest` مخصوص لاختبار BLoC/Cubit
- بيساعدنا نختبر states بسهولة
- بيدينا `expect` علشان نتوقع states معينة

### إيه الفرق بين expect و verify؟
- **expect**: نتوقع states معينة (هتحصل أثناء الـ act)
- **verify**: فحوصات إضافية بعد ما التيست ينتهي (مثلاً نتأكد من values)

### ليه بنستخدم seed؟
- علشان نضبط initial state بدون ما يدخل في `expect`
- ده مفيد لما عاوزين نجهز state معينة قبل الـ test

---

## ✨ الخلاصة

**الـ Cubit Tests:**
- ✅ بتختبر State Management (مهم جداً!)
- ✅ بتختبر UI integration
- ✅ بتختبر calculations
- ✅ بتختبر integration مع Use Cases
- ✅ أساسية لفهم الـ Presentation Layer

**الخلاصة النهائية:**
الآن عندك فهم كامل للـ Clean Architecture Testing! 🎉

---

تم بحمد الله! ❤️

