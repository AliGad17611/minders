import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/manger/cubit/crating_habit_cubit.dart';
import 'package:minders/features/creating_habit/manger/cubit/creating_habit_states.dart';
import 'package:minders/features/creating_habit/manger/helper/week_days_list.dart';

class WeekDaysListView extends StatelessWidget {
  const WeekDaysListView({
    super.key,
    required this.frequency,
  });

  final String frequency;

  @override
  Widget build(BuildContext context) {
    // Update selection when frequency changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CreatingHabitCubit>()
          .updateDaysSelectionBasedOnFrequency(frequency);
    });

    return BlocBuilder<CreatingHabitCubit, CreatingHabitStates>(
      builder: (context, state) {
        final cubit = context.read<CreatingHabitCubit>();
        List<bool> selectedDays = cubit.getSelectedDaysAsList(frequency);

        return SizedBox(
          height: 60,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              // Get today's weekday (0 = Sunday, 1 = Monday, etc.)
              int todayIndex = DateTime.now().weekday % 7;
              // Calculate the actual day index starting from today
              int actualDayIndex = (todayIndex + index) % 7;

              bool isSelected = selectedDays[actualDayIndex];
              bool isClickable = frequency == "Weekly";

              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 0, right: index == 6 ? 16 : 0),
                child: GestureDetector(
                  onTap: isClickable
                      ? () => cubit.toggleDaySelection(actualDayIndex)
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackShadow,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    width: 48,
                    height: 60,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: isSelected
                          ? Colors.white
                          : AppColors.choiceButtonColor,
                      child: Text(
                        weekDaysList[actualDayIndex],
                        style: isSelected
                            ? AppTextStyles.text13w600White
                                .copyWith(color: AppColors.blackTextColors)
                            : AppTextStyles.text13w600White,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 12);
            },
          ),
        );
      },
    );
  }
}
