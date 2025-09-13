import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/features/creating_habit/views/choice_habit_view.dart';
import 'package:minders/features/registration/splash/splash_screen.dart';
import 'package:minders/features/dashboard/viewmodels/health_viewmodel.dart';
import 'package:minders/features/dashboard/viewmodels/navigation_viewmodel.dart';

void main() {
  runApp(const MindersApp());
}

class MindersApp extends StatelessWidget {
  const MindersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HealthViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Minders App',
        theme: ThemeData.light().copyWith(
          primaryColor: AppColors.purpleMain,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.purpleMain,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          textTheme: GoogleFonts.rubikTextTheme(ThemeData.light().textTheme),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purpleMain,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
