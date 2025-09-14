import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.text24w500White,
    ),
    primaryColor: AppColors.purpleMain,
    scaffoldBackgroundColor: AppColors.purpleMain,
    textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
  );
}
