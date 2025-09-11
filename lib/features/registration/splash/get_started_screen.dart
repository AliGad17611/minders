import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/assets/app_icons.dart';
import 'package:minders/core/utils/themes/app_colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleMain,
      body: Column(
        children: [
          SvgPicture.asset(AppIcons.logo),
          Text('Hi , Welcome '),
          Text('to Main Habits'),
          Text('Explore the app, Find some peace of mind to achive good habits.'),
          SvgPicture.asset(AppFrames.meditation_grooup),
        ],
      ),
    );
  }
}
