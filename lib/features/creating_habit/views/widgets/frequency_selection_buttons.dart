import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/manger/cubit/crating_habit_cubit.dart';

class FrequencySelectionButtons extends StatelessWidget {
  const FrequencySelectionButtons({
    super.key,
    required this.selectedFrequency,
    required this.onFrequencyChanged,
  });

  final String selectedFrequency;
  final Function(String) onFrequencyChanged;

  static final List<String> frequencies = ["Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 20,
        children: frequencies.map((frequency) {
          final isSelected = selectedFrequency == frequency;

          return Expanded(
            child: TextButton(
              onPressed: () {
                onFrequencyChanged(frequency);
                context.read<CreatingHabitCubit>().updateFrequency(frequency);
              },
              style: TextButton.styleFrom(
                backgroundColor: isSelected
                    ? AppColors.whiteTextColors
                    : AppColors.choiceButtonColor,
              ),
              child: Text(
                frequency,
                style: isSelected
                    ? AppTextStyles.text14w600White
                        .copyWith(color: AppColors.blackTextColors)
                    : AppTextStyles.text14w600White,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
