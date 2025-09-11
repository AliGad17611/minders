import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle text30w500White = TextStyle(
    color: AppColors.whiteTextColors,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle text30w300White = TextStyle(
    color: AppColors.whiteTextColors,
    fontSize: 30,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle text16w300White = TextStyle(
    color: AppColors.whiteTextColors,
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle text14w500black = TextStyle(
    color: AppColors.blackTextColors,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}
