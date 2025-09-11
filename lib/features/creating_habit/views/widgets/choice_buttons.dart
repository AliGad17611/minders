import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/features/creating_habit/views/widgets/choice_button.dart';

class ChoiceButtons extends StatelessWidget {
  const ChoiceButtons(
      {super.key,
      required this.firstButtonText,
      required this.secondButtonText,
      required this.thirdButtonText,
      required this.buttonOnPressed});
  final String firstButtonText;
  final String secondButtonText;
  final String thirdButtonText;
  final VoidCallback buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ChoiceButton(
                text: firstButtonText, buttonOnPressed: buttonOnPressed),
            SizedBox(height: 30),
            ChoiceButton(
                text: secondButtonText, buttonOnPressed: buttonOnPressed),
            SizedBox(height: 30),
            ChoiceButton(
                text: thirdButtonText, buttonOnPressed: buttonOnPressed),
            SizedBox(height: 60),
          ],
        ),
        Positioned(
          top: -20,
          right: 10,
          child: SvgPicture.asset(AppFrames.right_cropped),
        ),
      ],
    );
  }
}
