import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minders/feature/creating_habit/views/morning_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: MorningView(),
    );
  }
}
