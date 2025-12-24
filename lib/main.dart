import 'package:currency_converter/core/resources/app_constants.dart';
import 'package:currency_converter/main_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/resources/theme_manager.dart';
import 'core/resources/app_routers.dart';

void main() async {
  await initializeApp();
  runApp(
    MyApp(startWidget: await getStartWidget()),
  
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: mainProviders(),
    //   child: BlocProvider(
    //     create: (_) => LanguageCubit(
    //       getLanguageUseCase: GetLanguageUseCase(),
    //       setLanguageUseCase: SetLanguageUseCase(),
    //     ),
    //     child: AppView(startWidget: startWidget),
    //   ),
    // );
    return  AppView(startWidget: startWidget
   );
  }
}

class AppView extends StatelessWidget {
  final Widget startWidget;

  const AppView({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
            // designSize: const Size(360, 690),
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
             
              theme: ThemeManager.light(context),
            home: startWidget,
             onGenerateRoute: AppRouteGenerator.generateRoute,
            ),
          );
  }
}