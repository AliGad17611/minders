import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/assets/app_images.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/registration/login_screen/login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.purpleAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, width: 142, height: 142),
            Text('Hi , Welcome ', style: AppTextStyles.text30w500White),
            Text('to Main Habits', style: AppTextStyles.text30w300White),
            SizedBox(height: 16),
            Text(
              'Explore the app, Find some peace of mind to achive good habits.',
              style: AppTextStyles.text16w300White,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Stack(
              children: [
                SvgPicture.asset(AppFrames.meditation_grooup),
                Positioned(
                  bottom: 57,
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 24),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Get Started',
                              style: AppTextStyles.text14w500black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
