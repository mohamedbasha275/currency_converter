# Currency Converter App

A modern Flutter application for currency conversion with real-time exchange rates, historical data visualization, and offline support.

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?style=flat-square&logo=github)](https://github.com/mohamedbasha275/currency_converter)
[![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2+-0175C2?style=flat-square&logo=dart)](https://dart.dev)

---

## 📱 Screenshots

![View Screens](assets/screenshots/images.png)

---

## 📥 Download APK

Download the latest release APK directly:

[![Download APK](https://img.shields.io/badge/Download-APK-green?style=for-the-badge&logo=android)](https://drive.google.com/file/d/1HCOgyaWFIGUbYWPg7KRnsKRiClhL1mhT/view?usp=sharing)

**Direct Link**: [Download APK](https://drive.google.com/file/d/1HCOgyaWFIGUbYWPg7KRnsKRiClhL1mhT/view?usp=sharing)

> **Note**: Make sure to enable "Install from Unknown Sources" in your Android settings before installing the APK.

---

## 🔗 Repository

**GitHub**: [https://github.com/mohamedbasha275/currency_converter](https://github.com/mohamedbasha275/currency_converter)

---

## 📋 Table of Contents

- [Screenshots](#-screenshots)
- [Download APK](#-download-apk)
- [Repository](#-repository)
- [Build Instructions](#-build-instructions)
- [Architecture Pattern](#-architecture-pattern)
- [Image Loader Library](#-image-loader-library)
- [Database](#-database)
- [Project Structure](#-project-structure)
- [Dependencies](#-dependencies)
- [Future Features](#-future-enhancements-optional--time-permitting)
- [Testing](#-testing)
- [Notes](#-notes)

---

## 🚀 Build Instructions

### Prerequisites

Before building the project, ensure you have the following installed:

- **Flutter SDK**: Version 3.9.2 or higher
- **Dart SDK**: Included with Flutter
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development on macOS)
- **Android SDK** (for Android development)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohamedbasha275/currency_converter.git
   cd currency_converter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate native assets and icons**
   ```bash
   flutter pub run flutter_launcher_icons
   flutter pub run flutter_native_splash:create
   ```

4. **Run the app**
   
   For Android:
   ```bash
   flutter run
   ```
   
   For iOS (macOS only):
   ```bash
   flutter run -d ios
   ```

5. **Build release APK (Android)**
   ```bash
   flutter build apk --release
   ```

6. **Build release IPA (iOS)**
   ```bash
   flutter build ios --release
   ```

### Additional Notes

- The app requires an internet connection for fetching real-time exchange rates
- Minimum Android SDK: 21 (Android 5.0 Lollipop)
- The app uses native splash screens and launcher icons configured in `pubspec.yaml`

---

## 🏗️ Architecture Pattern

### Clean Architecture with BLoC Pattern

This application follows **Clean Architecture** principles combined with the **BLoC (Business Logic Component)** pattern for state management.

#### Architecture Layers

The project is organized into three main layers:

1. **Presentation Layer** (`presentation/`)
   - UI components (Screens, Widgets)
   - State management using BLoC/Cubit
   - User interactions and UI logic

2. **Domain Layer** (`domain/`)
   - Business logic and use cases
   - Repository interfaces (contracts)
   - Entity models
   - Independent of external frameworks

3. **Data Layer** (`data/`)
   - Data sources (Remote API, Local Database)
   - Repository implementations
   - Data models and DTOs
   - External dependencies

#### Project Structure Example

```
lib/features/currency_converter/
├── data/
│   ├── datasources/          # API and local data sources
│   └── repositories/          # Repository implementations
├── domain/
│   ├── repositories/          # Repository interfaces
│   └── use_cases/             # Business logic use cases
└── presentation/
    ├── manager/               # BLoC/Cubit state management
    ├── screens/               # Full screen widgets
    └── widgets/               # Reusable UI components
```

#### Justification for Clean Architecture

1. **Separation of Concerns**
   - Each layer has a single, well-defined responsibility
   - Business logic is isolated from UI and data sources
   - Easy to understand and maintain

2. **Testability**
   - Domain layer can be tested independently without UI or database
   - Use cases can be unit tested with mock repositories
   - Data layer can be tested separately from business logic

3. **Independence**
   - Domain layer doesn't depend on Flutter or external libraries
   - Business rules remain unchanged when UI or data sources change
   - Framework-agnostic core logic

4. **Scalability**
   - Easy to add new features following the same pattern
   - Clear boundaries between layers prevent code coupling
   - Supports team collaboration with clear module boundaries

5. **Maintainability**
   - Changes in one layer don't affect others
   - Easy to locate and fix bugs
   - Code is self-documenting through structure

#### Justification for BLoC Pattern

1. **Reactive Programming**
   - Stream-based state management provides reactive UI updates
   - Handles asynchronous operations elegantly

2. **Separation of Business Logic from UI**
   - UI components are pure and testable
   - Business logic is centralized in BLoC/Cubit classes

3. **Predictable State Management**
   - Unidirectional data flow
   - Easy to debug with BLoC observer
   - State changes are traceable

4. **Flutter Ecosystem Integration**
   - Well-supported by Flutter team
   - Extensive community and resources
   - Works seamlessly with dependency injection (GetIt)

#### Dependency Injection

The project uses **GetIt** for dependency injection, which provides:

- **Loose Coupling**: Components depend on abstractions, not concrete implementations
- **Testability**: Easy to swap implementations with mocks for testing
- **Singleton Management**: Efficient resource management
- **Service Locator Pattern**: Centralized dependency registration

---

## 🖼️ Image Loader Library

### Cached Network Image (`cached_network_image: ^3.3.1`)

The application uses **Cached Network Image** for loading and caching currency flag images from network URLs.

#### Usage in the Project

The library is primarily used in the `CurrencyFlag` widget to display country flags:

```dart
CachedNetworkImage(
  imageUrl: url,
  width: size,
  height: size,
  memCacheWidth: 100,
  fit: BoxFit.cover,
  placeholder: (_, __) => Icon(Icons.flag_circle),
  errorWidget: (_, __, ___) => Icon(Icons.flag_circle),
)
```

#### Justification for Choosing Cached Network Image

1. **Automatic Caching**
   - Images are automatically cached to disk and memory
   - Reduces network requests and improves performance
   - Works offline after initial load

2. **Memory Optimization**
   - Built-in memory cache management
   - Configurable cache size limits
   - Prevents memory leaks and excessive memory usage

3. **Performance Benefits**
   - Fast image loading from cache
   - Reduces bandwidth consumption
   - Improves app responsiveness

4. **User Experience**
   - Placeholder widgets while loading
   - Error handling with fallback widgets
   - Smooth fade-in animations (configurable)
   - No flickering on image reloads

5. **Ease of Use**
   - Simple API similar to Flutter's `Image.network`
   - Drop-in replacement with additional features
   - Well-documented and maintained

6. **Production Ready**
   - Widely used in production Flutter apps
   - Actively maintained with regular updates
   - Handles edge cases (network errors, invalid URLs, etc.)

7. **Memory Cache Configuration**
   - Supports `memCacheWidth` and `memCacheHeight` for memory optimization
   - Reduces memory footprint for large images
   - Essential for apps displaying many images (currency flags list)

---

## 💾 Database

### SQLite with sqflite (`sqflite: ^2.3.0`)

The application uses **sqflite** (SQLite for Flutter) as the primary local database solution.

#### Usage in the Project

The database is used to store currency information locally:

- **Table**: `currencies`
- **Fields**: `id`, `code`, `name`, `symbol`, `flagUrl`, `createdAt`
- **Purpose**: Offline access to currency list, faster loading, reduced API calls

#### Database Helper Implementation

The project includes a `CurrencyDatabaseHelper` singleton class that manages:
- Database initialization
- CRUD operations for currencies
- Search functionality
- Batch insert operations for performance

#### Justification for Choosing sqflite

1. **Native SQLite Integration**
   - Direct access to SQLite database engine
   - Full SQL support for complex queries
   - High performance for relational data

2. **Offline Support**
   - Currency list available without internet connection
   - Improves user experience in low-connectivity scenarios
   - Reduces dependency on API availability

3. **Performance**
   - Fast read/write operations
   - Efficient batch operations
   - Indexed queries for quick searches
   - Suitable for large datasets

4. **Data Persistence**
   - Data survives app restarts
   - Reliable storage for critical app data
   - No data loss on app updates

5. **Flexibility**
   - Supports complex queries (JOIN, WHERE, ORDER BY)
   - Easy to add new tables and relationships
   - Migration support for schema changes

6. **Flutter Ecosystem**
   - Official Flutter plugin
   - Well-maintained and stable
   - Extensive documentation and community support

7. **Production Ready**
   - Used by thousands of Flutter apps
   - Battle-tested in production environments
   - Regular security and performance updates

### Shared Preferences (`shared_preferences: ^2.5.4`)

The application also uses **Shared Preferences** for simple key-value storage.

#### Usage in the Project

Shared Preferences is used for:
- Storing onboarding screen viewed status
- Simple app settings and user preferences
- Lightweight configuration data

#### Justification for Using Shared Preferences

1. **Simplicity**
   - Perfect for simple key-value pairs
   - No need for complex database setup
   - Easy to use API

2. **Performance**
   - Faster than database for simple data
   - Minimal overhead for small data
   - Synchronous read operations

3. **Appropriate Use Case**
   - Ideal for boolean flags (onboarding status)
   - Suitable for user preferences
   - Not overkill for simple settings

4. **Platform Native**
   - Uses native storage mechanisms (NSUserDefaults on iOS, SharedPreferences on Android)
   - Reliable and platform-optimized

#### Combined Database Strategy

The project uses a **hybrid approach**:

- **sqflite**: For structured, relational data (currency list with multiple fields)
- **Shared Preferences**: For simple settings and flags

This approach provides:
- Optimal performance for each use case
- Right tool for the right job
- Efficient resource utilization
- Maintainable codebase

---

## 📁 Project Structure

```
lib/
├── app_widgets/              # Shared app-wide widgets
├── common/                   # Common UI components
├── core/                     # Core functionality
│   ├── bloc_observer/        # BLoC observer for debugging
│   ├── di/                   # Dependency injection (GetIt)
│   ├── errors/               # Error handling
│   ├── extension/            # Dart extensions
│   ├── helper_functions/     # Utility functions
│   ├── navigation/           # Routing and navigation
│   ├── resources/            # App constants, colors, themes
│   ├── shared_preferences/   # SharedPreferences wrapper
│   └── use_cases/            # Base use case class
├── features/                 # Feature modules
│   ├── currency_converter/   # Currency conversion feature
│   ├── currency_list/        # Currency list feature
│   ├── historical_rates/     # Historical rates feature
│   ├── onboarding/          # Onboarding screens
│   └── home_screen.dart     # Main home screen
├── main.dart                 # App entry point
└── main_helper.dart         # App initialization helpers
```

---

## 📦 Key Dependencies

### State Management
- `bloc: ^9.1.0` - BLoC pattern implementation
- `flutter_bloc: ^9.1.0` - Flutter BLoC integration

### Dependency Injection
- `get_it: ^8.0.0` - Service locator and dependency injection

### Networking
- `dio: ^5.9.0` - HTTP client for API calls

### Database & Storage
- `sqflite: ^2.3.0` - SQLite database
- `shared_preferences: ^2.5.4` - Key-value storage

### Image Loading
- `cached_network_image: ^3.3.1` - Network image caching

### UI & Utilities
- `flutter_screenutil: ^5.9.0` - Responsive UI sizing
- `fl_chart: ^0.66.0` - Charts for historical rates
- `intl: ^0.19.0` - Internationalization and formatting
- `flutter_hooks: ^0.21.3+1` - Flutter hooks for stateful logic

### Error Handling
- `dartz: ^0.10.1` - Functional programming (Either for error handling)

### Testing
- `mocktail: ^1.0.4` - Mocking framework
- `bloc_test: ^10.0.0` - BLoC testing utilities

---

## 🔮 Future Enhancements (Optional – Time Permitting)

The following features are optional enhancements and are not required for the core functionality of the task.
They are listed to demonstrate the app's scalability and future potential if additional time is available.

### 🌙 Dark Mode

- Full dark theme support
- Manual toggle and system-based theme switching
- Improves usability and accessibility

### 🌍 Internationalization (i18n)

- Multi-language support (Arabic, English, etc.)
- RTL support for Arabic
- Dynamic language switching

### 🧪 Widget Tests & Integration Tests

- Widget tests for UI components
- Integration tests for critical user flows
- Improves code reliability and maintainability

### 💰 Cryptocurrency Support

- Support for major cryptocurrencies (BTC, ETH, etc.)
- Real-time crypto exchange rates
- Fiat ↔ Crypto conversion

### ⭐ Favorite Currencies

- Allow users to mark currencies as favorites
- Persistent storage of user preferences
- Quick access to frequently used currencies

### 📊 Currency Tracking (Monthly / Yearly)

- Track currency performance by month and year
- Trend visualization using charts
- Custom date range analysis

### 📝 Note

These enhancements are intentionally separated from the main scope of the task.
Thanks to the use of Clean Architecture and BLoC, these features can be added incrementally without impacting the existing implementation.

---

## 📝 Notes

- The app follows Flutter best practices and Material Design guidelines
- All features are organized using Clean Architecture principles
- The codebase is fully testable with comprehensive test coverage
- Error handling is implemented using the Either pattern from `dartz`
- The app supports offline functionality through local database caching

---

## 🧪 Testing

The project includes comprehensive unit tests covering all layers of the application. For detailed testing documentation, see:

📖 **[Test Documentation](./test/README.md)**

### Quick Test Commands

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run tests for a specific feature
flutter test test/features/currency_converter/
```

### Test Coverage

- ✅ **Data Sources**: API calls, error handling, data transformation
- ✅ **Repositories**: Error mapping, data flow, exception handling
- ✅ **Use Cases**: Business logic, parameter validation, error propagation
- ✅ **Cubits**: State management, user interactions, state transitions

---

## 👨‍💻 Development

For development guidelines and contribution instructions, please refer to the project's development documentation.

---

## 📄 License

This project is open source and available for educational purposes.

---

**Built with ❤️ using Flutter**

**Repository**: [https://github.com/mohamedbasha275/currency_converter](https://github.com/mohamedbasha275/currency_converter)
