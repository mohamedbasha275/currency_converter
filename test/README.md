# 🧪 Testing Documentation

Comprehensive testing documentation for the Currency Converter application.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Test Structure](#-test-structure)
- [Running Tests](#-running-tests)
- [Test Coverage](#-test-coverage)
- [Feature Tests](#-feature-tests)
  - [Currency Converter](#-currency-converter-feature)
  - [Currency List](#-currency-list-feature)
  - [Historical Rates](#-historical-rates-feature)
- [Testing Strategy](#-testing-strategy)
- [Test Utilities](#-test-utilities)

---

## 🎯 Overview

This application follows a comprehensive testing strategy covering all layers of Clean Architecture:

- **Data Layer**: Data sources and API interactions
- **Domain Layer**: Use cases and business logic
- **Presentation Layer**: BLoC/Cubit state management

### Testing Libraries

- **flutter_test**: Core Flutter testing framework
- **bloc_test**: Testing utilities for BLoC/Cubit
- **mocktail**: Mocking framework for creating test doubles
- **dartz**: Functional programming utilities (Either for error handling)

---

## 📁 Test Structure

The test directory mirrors the application structure:

```
test/
└── features/
    ├── currency_converter/
    │   ├── data_source_test.dart
    │   ├── repository_test.dart
    │   ├── use_case_test.dart
    │   └── cubit_test.dart
    ├── currency_list/
    │   ├── data_source_test.dart
    │   ├── repository_test.dart
    │   ├── use_case_test.dart
    │   └── cubit_test.dart
    └── historical_rates/
        ├── data_source_test.dart
        ├── repository_test.dart
        ├── use_case_test.dart
        └── cubit_test.dart
```

Each feature follows the same testing pattern:
1. **Data Source Tests**: Test API calls and data transformation
2. **Repository Tests**: Test error handling and data flow
3. **Use Case Tests**: Test business logic and validation
4. **Cubit Tests**: Test state management and UI logic

---

## 🚀 Running Tests

### Run All Tests

```bash
flutter test
```

### Run Tests for a Specific Feature

```bash
# Currency Converter
flutter test test/features/currency_converter/

# Currency List
flutter test test/features/currency_list/

# Historical Rates
flutter test test/features/historical_rates/
```

### Run a Specific Test File

```bash
flutter test test/features/currency_converter/cubit_test.dart
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### View Coverage Report

```bash
# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 📊 Test Coverage

The test suite aims for comprehensive coverage across all layers:

- **Data Sources**: API calls, error handling, data transformation
- **Repositories**: Error mapping, data flow, exception handling
- **Use Cases**: Business logic, parameter validation, error propagation
- **Cubits**: State transitions, user interactions, error states

### Coverage Goals

- **Unit Tests**: 80%+ coverage for business logic
- **BLoC Tests**: 100% state coverage for all Cubits
- **Edge Cases**: All error scenarios and boundary conditions

---

## 🎨 Feature Tests

## 💱 Currency Converter Feature

### Data Source Tests (`data_source_test.dart`)

Tests the `CurrencyConverterDataSource` implementation.

#### Test Cases:

1. **✅ Success Case**
   - **Test**: `should return rate when API succeeds`
   - **Scenario**: API returns valid exchange rate
   - **Expected**: Returns the exchange rate (e.g., 30.5)

2. **❌ Error Case - Null Rate**
   - **Test**: `should throw exception when rate is null`
   - **Scenario**: API returns null rate value
   - **Expected**: Throws `ServerException`

#### Coverage:
- ✅ Successful API response handling
- ✅ Null rate error handling
- ✅ API service integration

---

### Repository Tests (`repository_test.dart`)

Tests the `CurrencyConverterRepositoryImpl` error handling and data flow.

#### Test Cases:

1. **✅ Success Case**
   - **Test**: `should return Right when data source succeeds`
   - **Scenario**: Data source returns valid rate
   - **Expected**: Returns `Right(30.5)`

2. **❌ Error Case - Server Exception**
   - **Test**: `should return Left when ServerException occurs`
   - **Scenario**: Data source throws `ServerException`
   - **Expected**: Returns `Left(ServerFailure)`

3. **❌ Error Case - Network Error**
   - **Test**: `should return Left when no internet connection`
   - **Scenario**: `DioException` with connection error
   - **Expected**: Returns `Left(ServerFailure)`

#### Coverage:
- ✅ Success path with Right value
- ✅ ServerException mapping to Failure
- ✅ Network error handling (DioException)
- ✅ Error propagation from data source

---

### Use Case Tests (`use_case_test.dart`)

Tests the `ConvertCurrencyUseCase` business logic and validation.

#### Test Cases:

1. **✅ Valid Parameters**
   - **Test**: `should return Right when parameters are valid`
   - **Scenario**: Valid `from` and `to` currency codes
   - **Expected**: Returns `Right(30.5)` from repository

2. **❌ Empty From Parameter**
   - **Test**: `should return error when from is empty`
   - **Scenario**: Empty `from` currency code
   - **Expected**: Returns `Left(ServerFailure('Invalid parameters'))`

3. **❌ Repository Error**
   - **Test**: `should pass through error from repository`
   - **Scenario**: Repository returns error
   - **Expected**: Error is propagated without modification

#### Coverage:
- ✅ Parameter validation (empty strings)
- ✅ Success path delegation to repository
- ✅ Error propagation from repository
- ✅ Business rule enforcement

---

### Cubit Tests (`cubit_test.dart`)

Tests the `CurrencyConverterCubit` state management and user interactions.

#### Test Cases:

1. **Initial State**
   - **Test**: `should start with Initial state`
   - **Expected**: Cubit starts with `CurrencyConverterInitial`

2. **Convert Currency - Success**
   - **Test**: `should emit Loading then Loaded on success`
   - **Scenario**: Successful currency conversion
   - **Expected States**: 
     - `CurrencyConverterLoading`
     - `CurrencyConverterLoaded` with rate 30.5

3. **Convert Currency - Error**
   - **Test**: `should emit Loading then Error on failure`
   - **Scenario**: Use case returns error
   - **Expected States**:
     - `CurrencyConverterLoading`
     - `CurrencyConverterError` with error message

4. **Amount Calculation**
   - **Test**: `should calculate converted amount correctly`
   - **Scenario**: Amount = 100, Rate = 30.5
   - **Expected**: `convertedAmount = 3050.0`

5. **State Updates**
   - **Test**: `should update currencies`
   - **Scenario**: Setting from and to currencies
   - **Expected**: Emits `CurrencyConverterUpdated` states

6. **Amount Update**
   - **Test**: `should update amount`
   - **Scenario**: Setting amount value
   - **Expected**: Amount is updated correctly

7. **Currency Swap**
   - **Test**: `should swap currencies`
   - **Scenario**: Swapping from and to currencies
   - **Expected**: Currencies are swapped correctly

8. **Converted Amount Getter**
   - **Test**: `should calculate amount times rate`
   - **Scenario**: Amount and rate are set
   - **Expected**: Returns correct calculation

9. **Null Rate Handling**
   - **Test**: `should return 0 when rate is null`
   - **Scenario**: Rate is null
   - **Expected**: Returns 0.0

#### Coverage:
- ✅ Initial state
- ✅ Loading state transitions
- ✅ Success state with data
- ✅ Error state handling
- ✅ Currency selection and updates
- ✅ Amount input and calculation
- ✅ Currency swapping
- ✅ Converted amount calculation
- ✅ Null safety handling

---

## 📋 Currency List Feature

### Data Source Tests (`data_source_test.dart`)

Tests the `CurrencyListDataSource` with caching logic.

#### Test Cases:

1. **✅ Fetch from API (No Cache)**
   - **Test**: `should return currencies from API when no cache`
   - **Scenario**: No cached data available
   - **Expected**: 
     - Fetches from API
     - Saves to database
     - Returns currency list

2. **✅ Fetch from Cache**
   - **Test**: `should return currencies from cache when available`
   - **Scenario**: Cached data exists in database
   - **Expected**: 
     - Returns cached currencies
     - No API call made

3. **✅ Clear Cache**
   - **Test**: `should clear local cache`
   - **Scenario**: Clearing cached data
   - **Expected**: Database cache is cleared

#### Coverage:
- ✅ API fetching when no cache
- ✅ Cache retrieval
- ✅ Cache persistence
- ✅ Cache clearing
- ✅ Database integration

---

### Repository Tests (`repository_test.dart`)

Tests the `CurrencyListRepositoryImpl` error handling.

#### Test Cases:

1. **✅ Get Currencies - Success**
   - **Test**: `should return Right when data source succeeds`
   - **Expected**: Returns `Right(List<CurrencyListEntity>)`

2. **❌ Get Currencies - Server Exception**
   - **Test**: `should return Left when ServerException occurs`
   - **Expected**: Returns `Left(ServerFailure)`

3. **❌ Get Currencies - Network Error**
   - **Test**: `should return Left when no internet connection`
   - **Expected**: Returns `Left(ServerFailure)`

4. **✅ Refresh Currencies - Success**
   - **Test**: `should return Right when refresh succeeds`
   - **Scenario**: Clearing cache and fetching new data
   - **Expected**: 
     - Cache cleared
     - New data fetched
     - Returns `Right(List<CurrencyListEntity>)`

5. **❌ Refresh Currencies - Failure**
   - **Test**: `should return Left when refresh fails`
   - **Expected**: Returns `Left(ServerFailure)`

#### Coverage:
- ✅ Success path for get currencies
- ✅ Success path for refresh
- ✅ ServerException handling
- ✅ Network error handling
- ✅ Cache clearing on refresh

---

### Use Case Tests (`use_case_test.dart`)

Tests the `GetCurrenciesUseCase` business logic.

#### Test Cases:

1. **✅ Success Case**
   - **Test**: `should return currencies when repository succeeds`
   - **Expected**: Returns `Right(List<CurrencyListEntity>)`

2. **❌ Error Propagation**
   - **Test**: `should pass through error from repository`
   - **Expected**: Error is propagated without modification

#### Coverage:
- ✅ Success path delegation
- ✅ Error propagation

---

### Cubit Tests (`cubit_test.dart`)

Tests the `CurrencyListCubit` state management and search functionality.

#### Test Cases:

1. **Initial State**
   - **Test**: `should start with Initial state`
   - **Expected**: Starts with `CurrencyListInitial`

2. **Get Currencies - Success**
   - **Test**: `should emit Loading then Loaded on success`
   - **Expected States**:
     - `CurrencyListLoading`
     - `CurrencyListLoaded` with currencies

3. **Get Currencies - Error**
   - **Test**: `should emit Loading then Error on failure`
   - **Expected States**:
     - `CurrencyListLoading`
     - `CurrencyListError` with message

4. **Search Currencies**
   - **Test**: `should filter currencies by search query`
   - **Scenario**: Search for "USD"
   - **Expected**: 
     - Filters currencies
     - Updates `filteredCurrencies`
     - Returns matching currencies

5. **Empty Search Query**
   - **Test**: `should return all currencies when query is empty`
   - **Scenario**: Empty search string
   - **Expected**: Shows all currencies

6. **Refresh Currencies - Success**
   - **Test**: `should emit Loading then Loaded on refresh success`
   - **Expected States**:
     - `CurrencyListLoading`
     - `CurrencyListLoaded`

7. **Refresh Currencies - Error**
   - **Test**: `should emit Loading then Error on refresh failure`
   - **Expected States**:
     - `CurrencyListLoading`
     - `CurrencyListError`

#### Coverage:
- ✅ Initial state
- ✅ Loading and loaded states
- ✅ Error state handling
- ✅ Search functionality
- ✅ Filter logic
- ✅ Empty search handling
- ✅ Refresh functionality
- ✅ State transitions

---

## 📈 Historical Rates Feature

### Data Source Tests (`data_source_test.dart`)

Tests the `HistoricalRatesDataSource` API integration.

#### Test Cases:

1. **✅ Success Case**
   - **Test**: `should return rates when API succeeds`
   - **Scenario**: API returns historical rates data
   - **Expected**: Returns list of `HistoricalRateModel`

2. **❌ Empty Results**
   - **Test**: `should throw exception when results are empty`
   - **Scenario**: API returns empty results object
   - **Expected**: Throws `ServerException`

3. **❌ Empty Rates List**
   - **Test**: `should throw exception when rates list is empty`
   - **Scenario**: Results object is empty
   - **Expected**: Throws `ServerException`

#### Coverage:
- ✅ Successful API response parsing
- ✅ Empty results handling
- ✅ Empty rates list handling
- ✅ Date parsing and rate extraction

---

### Repository Tests (`repository_test.dart`)

Tests the `HistoricalRatesRepositoryImpl` error handling.

#### Test Cases:

1. **✅ Success Case**
   - **Test**: `should return Right when data source succeeds`
   - **Expected**: Returns `Right(List<HistoricalRateEntity>)`

2. **❌ Server Exception**
   - **Test**: `should return Left when ServerException occurs`
   - **Expected**: Returns `Left(ServerFailure)`

3. **❌ Network Error**
   - **Test**: `should return Left when no internet connection`
   - **Expected**: Returns `Left(ServerFailure)`

#### Coverage:
- ✅ Success path
- ✅ ServerException mapping
- ✅ Network error handling

---

### Use Case Tests (`use_case_test.dart`)

Tests the `GetHistoricalRatesUseCase` validation and business logic.

#### Test Cases:

1. **✅ Success Case**
   - **Test**: `should return rates when repository succeeds`
   - **Expected**: Returns `Right(List<HistoricalRateEntity>)`

2. **❌ Null Parameters**
   - **Test**: `should return error when params is null`
   - **Scenario**: No parameters provided
   - **Expected**: Returns `Left(ServerFailure('Invalid parameters'))`

3. **❌ Repository Error**
   - **Test**: `should pass through error from repository`
   - **Expected**: Error is propagated

#### Coverage:
- ✅ Parameter validation (null check)
- ✅ Success path delegation
- ✅ Error propagation

---

### Cubit Tests (`cubit_test.dart`)

Tests the `HistoricalRatesCubit` state management.

#### Test Cases:

1. **Initial State**
   - **Test**: `should start with Initial state`
   - **Expected**: Starts with `HistoricalRatesInitial`

2. **Set Currencies**
   - **Test**: `should set currencies and emit Idle state`
   - **Scenario**: Setting from and to currencies
   - **Expected**: 
     - Emits `HistoricalRatesIdle`
     - Currencies are set correctly

3. **Same Currencies (No State Change)**
   - **Test**: `should not emit new state if currencies are the same`
   - **Scenario**: Setting same currencies again
   - **Expected**: No new state emitted

4. **Get Historical Rates - Success**
   - **Test**: `should emit Loading then Loaded on success`
   - **Expected States**:
     - `HistoricalRatesLoading`
     - `HistoricalRatesLoaded` with rates

5. **Get Historical Rates - Error**
   - **Test**: `should handle error from use case`
   - **Scenario**: Use case returns error
   - **Expected**: State is not `HistoricalRatesLoaded`

6. **Null Currencies**
   - **Test**: `should not emit states when currencies are null`
   - **Scenario**: Currencies not set
   - **Expected**: Remains in `HistoricalRatesInitial`

#### Coverage:
- ✅ Initial state
- ✅ Currency setting
- ✅ Idle state management
- ✅ Loading and loaded states
- ✅ Error handling
- ✅ Null currency validation
- ✅ State transition prevention for same currencies

---

## 🎯 Testing Strategy

### Test Pyramid

```
        /\
       /  \      E2E Tests (Future)
      /____\
     /      \    Integration Tests (Future)
    /________\
   /          \   Widget Tests (Future)
  /____________\
 /              \  Unit Tests (Current)
/________________\
```

### Current Focus: Unit Tests

1. **Data Source Layer**: Test API calls, data transformation, error handling
2. **Repository Layer**: Test error mapping, data flow, exception handling
3. **Use Case Layer**: Test business logic, validation, error propagation
4. **Cubit Layer**: Test state management, user interactions, state transitions

### Testing Principles

1. **Isolation**: Each test is independent and can run in any order
2. **Mocking**: External dependencies are mocked using `mocktail`
3. **Arrange-Act-Assert**: Clear test structure for readability
4. **Edge Cases**: All error scenarios and boundary conditions are tested
5. **State Coverage**: All possible state transitions are tested

---

## 🛠️ Test Utilities

### Mocking Framework: `mocktail`

Used for creating mock objects:

```dart
class MockApiService extends Mock implements ApiService {}
class MockRepository extends Mock implements Repository {}
```

### BLoC Testing: `bloc_test`

Used for testing BLoC/Cubit state management:

```dart
blocTest<Cubit, State>(
  'description',
  build: () => cubit,
  act: (cubit) => cubit.action(),
  expect: () => [State1(), State2()],
);
```

### Error Handling: `dartz`

Used for functional error handling with `Either`:

```dart
Either<Failure, Success>
- Right(value): Success case
- Left(failure): Error case
```

---

## 📝 Test Naming Convention

Tests follow a clear naming pattern:

- **Format**: `should [expected behavior] when [condition]`
- **Examples**:
  - `should return rate when API succeeds`
  - `should throw exception when rate is null`
  - `should emit Loading then Loaded on success`

---

## ✅ Test Checklist

### Data Source Tests
- [x] Success case with valid API response
- [x] Error cases (null values, empty responses)
- [x] API service integration
- [x] Data transformation

### Repository Tests
- [x] Success path (Right value)
- [x] ServerException mapping
- [x] Network error handling
- [x] Error propagation

### Use Case Tests
- [x] Parameter validation
- [x] Success path delegation
- [x] Error propagation
- [x] Business rule enforcement

### Cubit Tests
- [x] Initial state
- [x] Loading states
- [x] Success states
- [x] Error states
- [x] User interactions
- [x] State transitions

---

## 🔮 Future Test Enhancements

### Widget Tests
- Test individual widget rendering
- Test widget interactions
- Test widget state changes

### Integration Tests
- Test complete user flows
- Test feature interactions
- Test navigation flows

### E2E Tests
- Test app launch and initialization
- Test complete user journeys
- Test offline/online scenarios

---

## 📚 Additional Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [bloc_test Package](https://pub.dev/packages/bloc_test)
- [mocktail Package](https://pub.dev/packages/mocktail)
- [dartz Package](https://pub.dev/packages/dartz)

---

**Last Updated**: Based on current test suite structure

**Test Coverage**: Comprehensive unit tests for all features and layers

