import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_color.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class MorningView extends StatelessWidget {
  const MorningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E97FD),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 111,
          ),
          Text(
            "Whats time do you \nusually wake up?",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: AppColor.whiteTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 200,
          ),
          Expanded(
            child: Stack(
              children: [
                SvgPicture.asset(
                  AppFrames.sunny_group,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 225,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: TimePickerSpinner(
                      locale: const Locale('en', ''),
                      time: DateTime.now(),
                      is24HourMode: false,
                      isShowSeconds: false,
                      spacing: 10,
                      itemHeight: 80,
                      normalTextStyle: const TextStyle(
                        fontSize: 24,
                      ),
                      highlightedTextStyle: const TextStyle(
                          fontSize: 24, color: AppColor.whiteTextColor),
                      isForce2Digits: true,
                      onTimeChange: (time) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
