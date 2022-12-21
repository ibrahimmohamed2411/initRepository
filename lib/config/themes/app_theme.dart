import 'package:flutter/material.dart';
import '../../core/utils/app_strings.dart';

import '../../core/utils/app_colors.dart';
import '../locale/app_localizations.dart';

ThemeData appTheme(Locale locale) {
  return ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      color: Colors.white,
      elevation: 1,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: locale.languageCode == AppStrings.englishCode
            ? AppStrings.robotoFontFamily
            : AppStrings.cairoFontFamily,
      ),
    ),
    fontFamily: locale.languageCode == AppStrings.englishCode
        ? AppStrings.robotoFontFamily
        : AppStrings.cairoFontFamily,
  );
}
