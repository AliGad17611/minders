import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minders/feature/creating_habit/views/morning_view.dart';

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
        primaryColor: Color(0xFF8E97FD),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
      ),
      home: SplashScreen(),
    );
  }
}
