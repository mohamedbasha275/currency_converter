# Unit Tests - Currency List Feature

## 📊 النتيجة
```
✅ 14 تيست - كلهم نجحوا
⏱️ وقت التشغيل: ~1 ثانية
```

---

## 📁 الملفات

### 1. `data_source_test.dart` (3 tests)
**الطبقة:** Data Layer - API Integration

📖 **[اقرأ الشرح المفصل →](DATA_SOURCE_README.md)**

**التيستات:**
- ✅ يرجع currencies من API (مفيش cache)
- ✅ يرجع currencies من cache
- ✅ يمسح الـ cache

---

### 2. `repository_test.dart` (5 tests)
**الطبقة:** Domain Layer - Business Logic

📖 **[اقرأ الشرح المفصل →](REPOSITORY_README.md)**

**التيستات:**
- ✅ getCurrencies: data source نجح → Right(currencies)
- ❌ getCurrencies: ServerException → Left(ServerFailure)
- ❌ getCurrencies: مفيش نت → Left(ServerFailure)
- ✅ refreshCurrencies: refresh نجح
- ❌ refreshCurrencies: refresh فشل

---

### 3. `use_case_test.dart` (2 tests)
**الطبقة:** Domain Layer - Application Logic

📖 **[اقرأ الشرح المفصل →](USE_CASE_README.md)**

**التيستات:**
- ✅ repository نجح → Right(currencies)
- ❌ repository فشل → يمرر error

**مثال:**
```dart
// ✅ Happy Path: repository يرجع currencies
test('should return currencies when repository succeeds', () async {
  final fakeCurrencies = [/* ... */];
  when(() => mockRepository.getCurrencies())
      .thenAnswer((_) async => Right(fakeCurrencies));

  final result = await useCase.call();

  expect(result, Right(fakeCurrencies));
});
```

---

### 4. `cubit_test.dart` (7 tests)
**الطبقة:** Presentation Layer - State Management

📖 **[اقرأ الشرح المفصل →](CUBIT_README.md)**

**التيستات:**
- 🎬 Initial state
- ✅ getCurrencies: Loading → Loaded
- ❌ getCurrencies: Loading → Error
- 🔍 searchCurrencies: فلترة العملات
- 🔍 searchCurrencies: query فاضي → كل العملات
- 🔄 refreshCurrencies: Loading → Loaded
- ❌ refreshCurrencies: Loading → Error

**مثال:**
```dart
// ✅ Happy Path: use case نجح
blocTest<CurrencyListCubit, CurrencyListState>(
  'should emit Loading then Loaded on success',
  build: () {
    when(() => mockUseCase.call(any()))
        .thenAnswer((_) async => Right(fakeCurrencies));
    return cubit;
  },
  act: (cubit) => cubit.getCurrencies(),
  expect: () => [
    isA<CurrencyListLoading>(),
    isA<CurrencyListLoaded>(),
  ],
);
```

---

## 🚀 طريقة التشغيل

```bash
# كل التيستات
flutter test test/features/currency_list/

# ملف واحد
flutter test test/features/currency_list/use_case_test.dart
flutter test test/features/currency_list/cubit_test.dart
```

---

## 📊 Coverage

| الطبقة | التيستات | الوصف |
|--------|---------|-------|
| Data Source | 3 | CurrencyListDataSource |
| Repository | 5 | CurrencyListRepository |
| Use Case | 2 | GetCurrenciesUseCase |
| Cubit | 7 | CurrencyListCubit |
| **المجموع** | **17** | |

---

## 📚 ملفات الشرح التفصيلي

كل ملف تيست له ملف README منفصل يشرح كل حاجة بالتفصيل:

### 1. 📡 [DATA_SOURCE_README.md](DATA_SOURCE_README.md)
- شرح الـ Data Source Layer
- Cache Strategy
- API Integration

### 2. 🔄 [REPOSITORY_README.md](REPOSITORY_README.md)
- شرح الـ Repository Layer
- Error Handling
- Refresh Logic

---

## 💡 المميزات

- ✅ بسيطة وواضحة
- ✅ تغطي الحالات الأساسية
- ✅ نفس الأسلوب المستخدم في currency_converter
- ✅ سريعة في التشغيل

---

تم بحمد الله! ❤️

