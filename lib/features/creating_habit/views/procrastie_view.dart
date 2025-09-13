import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/views/productivity_view.dart';
import 'package:minders/features/creating_habit/views/widgets/choice_buttons.dart';
import 'package:minders/features/common/top_space.dart';

class ProcrastieView extends StatelessWidget {
  const ProcrastieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopSpace(),
          Text("Do you Procrastinate?", style: AppTextStyles.text30w600White),
          Spacer(),
          ChoiceButtons(
            firstButtonText: "Yes and i’m ready to change that",
            secondButtonText: "No, I easily finish the tasks at hand",
            thirdButtonText: "Not ready to answer",
            buttonOnPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductivityView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
