import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_router.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ValueNotifier(const Locale('ar')),
        builder: (context, locale, _) {
          return MaterialApp(
            title: 'Housing System',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColor.grey1,
              appBarTheme: AppBarTheme(backgroundColor: AppColor.grey1),
              useMaterial3: true,
              inputDecorationTheme: InputDecorationTheme(
                fillColor: AppColor.grey1,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColor.grey2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColor.grey2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColor.grey2),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColor.grey2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColor.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColor.red),
                ),
              ),
            ),
            initialRoute: AppRoutes.loginPage,
            onGenerateRoute: AppRouter.generateRoute,
            localizationsDelegates: const [
              // S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: locale,
            supportedLocales: const [
              Locale("en"), // English
              Locale("ar"), // Arabic
            ],
          );
        });
  }
}
