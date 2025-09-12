import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/features/registration/splash/splash_screen.dart';

void main() {
  runApp(const MindersApp());
}

class MindersApp extends StatelessWidget {
  const MindersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minders App',
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColors.purpleMain,
        scaffoldBackgroundColor: AppColors.purpleMain,
        textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
      ),
      home: SplashScreen(),
    );
  }
}
