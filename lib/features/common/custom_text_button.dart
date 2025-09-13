import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.buttonOnPressed,
    required this.text,
    required this.textStyle,
    this.horizontalPadding = 55,
  });

  final VoidCallback buttonOnPressed;
  final String text;
  final TextStyle textStyle;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonOnPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.whiteTextColors,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 10,
        ),
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
