import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:currency_converter/core/dio/api_service.dart';
import 'package:currency_converter/core/shared_preferences/app_prefs.dart';

final GetIt getIt = GetIt.instance;

/// Sets up all dependencies for the service locator.
/// Call this at app startup.
Future<void> setupServiceLocator() async {
  _registerCoreServices();
  await _registerAsyncServices();
  _registerRepositories();
}

/// Registers core synchronous services.
void _registerCoreServices() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
}

/// Registers asynchronous services (e.g., SharedPreferences).
Future<void> _registerAsyncServices() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);
  getIt.registerLazySingleton<AppPreferences>(
    () => AppPreferences(getIt<SharedPreferences>()),
  );
 


}

/// Registers all repositories and their dependencies.
void _registerRepositories() {
  // TODO: Register repositories here when needed
}
