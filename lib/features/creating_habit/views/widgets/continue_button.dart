import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.whiteTextColors,
          ),
          child: Text(
            "Continue",
            style: AppTextStyles.text16w500Black
                .copyWith(color: AppColors.grayTextColors),
          )),
    );
  }
}
