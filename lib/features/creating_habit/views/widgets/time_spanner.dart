import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class TimeSpanner extends StatelessWidget {
  const TimeSpanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TimePickerSpinner(
      locale: const Locale('en', ''),
      time: DateTime.now(),
      is24HourMode: false,
      isShowSeconds: false,
      spacing: 40,
      itemHeight: 50,
      normalTextStyle: const TextStyle(
        fontSize: 24,
      ),
      highlightedTextStyle:
          const TextStyle(fontSize: 24, color: AppColors.whiteTextColors),
      isForce2Digits: true,
      onTimeChange: (time) {},
    );
  }
}
