import 'package:flutter/material.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/features/creating_habit/views/procrastie_view.dart';
import 'package:minders/features/creating_habit/views/widgets/day_view.dart';

class NightView extends StatelessWidget {
  const NightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleMain,
      body: DayView(
        image: AppFrames.night_group,
        text: "When do you want to \nreflect on your day",
        backgroundColor: AppColors.purpleMain,
        buttonOnPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProcrastieView()),
          );
        },
      ),
    );
  }
}
