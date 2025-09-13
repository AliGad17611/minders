import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/common/custom_text_button.dart';
import 'package:minders/features/creating_habit/views/widgets/time_spanner.dart';

class DayFrontStack extends StatelessWidget {
  const DayFrontStack({
    super.key,
    required this.image,
    required this.buttonOnPressed,
  });
  final String image;
  final VoidCallback buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.timePickerBackgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TimeSpanner(),
                  SizedBox(height: 20),
                  CustomTextButton(
                    buttonOnPressed: buttonOnPressed,
                    text: "GET STARTED",
                    textStyle: AppTextStyles.text16w500Black,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
