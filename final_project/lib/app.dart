import 'dart:io';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:final_project/core/cubit/theme_cubit.dart';
import 'package:final_project/core/routes/app_routes.dart';
import 'package:final_project/core/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeCubit.instance,
      builder: (context, _) {
        final isDark = ThemeCubit.instance.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                )
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                ),
          child: MaterialApp.router(
            routerConfig: AppRouter.routes,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            builder: (_, child) => SafeArea(
              top: false,
              bottom: Platform.isAndroid,
              child: child!,
            ),
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeCubit.instance.themeMode,
          ),
        );
      },
    );
  }
}






