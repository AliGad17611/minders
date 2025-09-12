import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/assets/app_icons.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/common/custom_elevatedButton.dart';

class AuthFormScreen extends StatelessWidget {
  const AuthFormScreen({
    super.key,
    required this.title,
    required this.middleText,
    required this.bottomText,
    required this.form,
    this.onChange,
  });
  final String title;
  final String middleText;
  final List<String> bottomText;

  final Widget form;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: Stack(
        children: [
          SvgPicture.asset(AppFrames.top_cropped),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                              side: BorderSide(color: AppColors.borderSecondary),
                            ),
                            padding: EdgeInsets.all(18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Text(
                      title,
                      style: AppTextStyles.text28w700black,
                    ),
                    SizedBox(height: 33),
                    CustomElevatedButton(
                      title: "CONTINUE WITH FACEBOOK",
                      preffixIcon: AppIcons.facebook,
                      backgroundColor: Color(0xff7583CA),
                      foregroundColor: AppColors.whiteTextColors,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    CustomElevatedButton(
                      title: "CONTINUE WITH GOOGLE",
                      preffixIcon: AppIcons.google,
                      onPressed: () {},
                    ),
                    SizedBox(height: 40),
                    Text(
                      middleText,
                      style: AppTextStyles.text14w700Tertiary,
                    ),
                    SizedBox(height: 20),
                    form,
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bottomText[0],
                          style: AppTextStyles.text14w500black.copyWith(
                            color: AppColors.tertiaryTextColors,
                          ),
                        ),
                        InkWell(
                          onTap: onChange,
                          child: Text(
                            bottomText[1],
                            style: AppTextStyles.text14w500black.copyWith(
                              color: AppColors.purpleAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
