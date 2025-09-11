import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton(
      {super.key, required this.text, required this.buttonOnPressed});
  final String text;
  final VoidCallback buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonOnPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.choiceButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text, style: AppTextStyles.text14w600White)),
      ),
    );
  }
}
