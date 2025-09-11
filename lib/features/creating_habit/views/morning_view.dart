import 'package:flutter/material.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/features/creating_habit/views/night_view.dart';
import 'package:minders/features/creating_habit/views/widgets/day_view.dart';

class MorningView extends StatelessWidget {
  const MorningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleAccent,
      body: DayView(
        image: AppFrames.sunny_group,
        text: "Whats time do you \nusually wake up?",
        backgroundColor: AppColors.purpleMain,
        buttonOnPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NightView()),
          );
        },
      ),
    );
  }
}
