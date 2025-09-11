import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/views/widgets/day_front_stack.dart';
import 'package:minders/features/creating_habit/views/widgets/top_space.dart';

class DayView extends StatelessWidget {
  const DayView({
    super.key,
    required this.image,
    required this.text,
    required this.buttonOnPressed,
    required this.backgroundColor,
  });
  final String image;
  final String text;
  final VoidCallback buttonOnPressed;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TopSpace(),
        Text(
          text,
            style: AppTextStyles.text30w600White,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 150,
        ),
        DayFrontStack(image: image, buttonOnPressed: buttonOnPressed),
      ],
    );
  }
}
