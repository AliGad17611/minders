import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Congrats")),
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(child: SvgPicture.asset(AppFrames.congrats_girl)),
          SizedBox(height: 87),
          Text("Greate your challenge has start", style: AppTextStyles.text21w500white),
        ],
      ),
    );
  }
}
