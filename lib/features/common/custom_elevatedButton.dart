import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.preffixIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.onPressed,
    this.borderColor,
  });

  final String title;
  final String? preffixIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        ),
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 34),
        backgroundColor: backgroundColor ?? AppColors.whiteTextColors,
        side: BorderSide(color: borderColor ?? AppColors.borderSecondary),
        overlayColor: AppColors.purpleMain,
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          if (preffixIcon != null) SvgPicture.asset(preffixIcon!),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.text14w500black.copyWith(
                  color: foregroundColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
