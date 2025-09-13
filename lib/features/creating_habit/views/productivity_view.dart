import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/views/choice_habit_view.dart';
import 'package:minders/features/creating_habit/views/widgets/choice_buttons.dart';
import 'package:minders/features/common/top_space.dart';

class ProductivityView extends StatelessWidget {
  const ProductivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopSpace(),
          Text("What do you hope to \nachive with Main Habit",
              style: AppTextStyles.text30w600White,
              textAlign: TextAlign.center),
          Spacer(),
          ChoiceButtons(
            firstButtonText: "I want to build good habits",
            secondButtonText: "I want to be organized",
            thirdButtonText: "Not ready to answer",
            buttonOnPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChoiceHabitView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
