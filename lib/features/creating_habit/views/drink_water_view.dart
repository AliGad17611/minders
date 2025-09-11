import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/views/morning_view.dart';
import 'package:minders/features/creating_habit/views/widgets/choice_button.dart';
import 'package:minders/features/creating_habit/views/widgets/top_space.dart';

class DrinkWaterView extends StatelessWidget {
  const DrinkWaterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(AppFrames.water),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopSpace(height: 90),
                  Text("SET YOUR GOALS", style: AppTextStyles.text30w600White),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text("Set your goals", style: AppTextStyles.text14w600White),
          SizedBox(height: 20),
          ChoiceButton(
              text: "5        Glasses",
              buttonOnPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MorningView()),
                );
              }),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.choiceButtonColor,
                      ),
                      child:
                          Text("Daily", style: AppTextStyles.text14w600White)),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.whiteTextColors,
                      ),
                      child: Text("Weekly",
                          style: AppTextStyles.text14w600White
                              .copyWith(color: AppColors.blackTextColors))),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.choiceButtonColor,
                      ),
                      child: Text("Monthly",
                          style: AppTextStyles.text14w600White)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
