import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/manger/models/habit_model.dart';
import 'package:minders/features/creating_habit/views/drink_water_view.dart';

class HabitCircle extends StatelessWidget {
  const HabitCircle({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DrinkWaterView(
            habit: HabitModel(
              title: index % 2 == 0 ? "Drinking water" : "Morning Walk",
              goalAmount: "0",
              goalUnit: "ml",
              selectedWeekDays: [],
              timeOfDayToRepeat: 0,
            ),
          )),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: AppColors.purpleAccent,
            child: SvgPicture.asset(
              index % 2 == 0 ? AppFrames.g10 : AppFrames.Illustartion,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(height: 10),
          Text(index % 2 == 0 ? "Drinking water" : "Morning Walk",
              style: AppTextStyles.text13w600White),
        ],
      ),
    );
  }
}
