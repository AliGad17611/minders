import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/manger/cubit/crating_habit_cubit.dart';
import 'package:minders/features/creating_habit/views/morning_view.dart';

class HabitContinueButton extends StatelessWidget {
  const HabitContinueButton({
    super.key,
    required this.selectedQuantity,
    required this.selectedUnit,
  });

  final String selectedQuantity;
  final String selectedUnit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Update habit details with current selections (days are already managed by WeekDaysListView)
            context.read<CreatingHabitCubit>().updateHabitDetails(
                selectedQuantity,
                selectedUnit,
                null, // Don't override selected days - they're managed by WeekDaysListView
                0 // Will be updated based on time selection
                );

            // Navigate to next step - you can customize this navigation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MorningView(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.whiteTextColors,
          ),
          child: Text(
            "Continue",
            style: AppTextStyles.text16w500Black
                .copyWith(color: AppColors.grayTextColors),
          ),
        ),
      ),
    );
  }
}
