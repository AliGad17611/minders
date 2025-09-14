import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/common/top_space.dart';
import 'package:minders/features/creating_habit/views/widgets/habit_circle.dart';

class ChoiceHabitView extends StatelessWidget {
  const ChoiceHabitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopSpace(),
          Text(
            "Choos your fist hibit",
            style: AppTextStyles.text30w600White,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return HabitCircle(index: index);
              },
              itemCount: 6,
            ),
          )
        ],
      ),
    );
  }
}
