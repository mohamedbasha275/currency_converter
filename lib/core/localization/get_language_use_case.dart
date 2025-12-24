import 'package:currency_converter/core/di/service_locator.dart';
import 'package:currency_converter/core/shared_preferences/app_prefs.dart';

class GetLanguageUseCase {

  GetLanguageUseCase();

  Future<String> call() async {
    AppPreferences appPreferences = getIt.get<AppPreferences>();
    String languageCode = appPreferences.getLanguageCode();
    return languageCode;
  }
}
