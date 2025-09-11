import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minders/core/utils/assets/app_icons.dart';
import 'package:minders/core/utils/themes/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.purpleSecondary,
              AppColors.babyBlue,
            ]),
          ),
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.logo),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
