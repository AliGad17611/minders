import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minders/features/creating_habit/manger/cubit/creating_habit_states.dart';
import 'package:minders/features/creating_habit/manger/helper/week_days_list.dart';
import 'package:minders/features/creating_habit/manger/models/day_model.dart';
import 'package:minders/features/creating_habit/manger/models/habit_model.dart';
import 'package:minders/features/creating_habit/manger/services/create_habit_service.dart';

class CreatingHabitCubit extends Cubit<CreatingHabitStates> {
  CreatingHabitCubit() : super(CreatingHabitInitialState());
  late HabitModel habit;

  //* select Habit's title
  void selectHabitTitle(HabitModel habit) {
    this.habit = habit;
    emit(CreatingHabitTitleSelectedState(habit: habit));
  }

  //* select Habit's details (goal amount, goal unit, selected week days, time of day to repeat)
  void selectHabitDetails(String goalAmount, String goalUnit,
      List<DayModel> selectedWeekDays, int timeOfDayToRepeat) {
    habit.goalAmount = goalAmount;
    habit.goalUnit = goalUnit;
    habit.selectedWeekDays = selectedWeekDays;
    habit.timeOfDayToRepeat = timeOfDayToRepeat;
    emit(CreatingHabitDetailsSelectedState(
        goalAmount: goalAmount,
        goalUnit: goalUnit,
        selectedWeekDays: selectedWeekDays,
        timeOfDayToRepeat: timeOfDayToRepeat));
  }

  //* update Habit's details (goal amount or goal unit or selected week days or time of day to repeat)
  void updateHabitDetails(String? goalAmount, String? goalUnit,
      List<DayModel>? selectedWeekDays, int? timeOfDayToRepeat) {
    // Initialize habit if not already done
    try {
      habit.goalAmount; // Try to access to check if initialized
    } catch (e) {
      habit = HabitModel(
        title: '',
        goalAmount: '5',
        goalUnit: 'Glasses',
        selectedWeekDays: [],
        timeOfDayToRepeat: 0,
      );
    }

    // Update habit properties
    habit.goalAmount = goalAmount ?? habit.goalAmount;
    habit.goalUnit = goalUnit ?? habit.goalUnit;
    habit.selectedWeekDays = selectedWeekDays ?? habit.selectedWeekDays;
    habit.timeOfDayToRepeat = timeOfDayToRepeat ?? habit.timeOfDayToRepeat;

    // Create or update state
    if (state is CreatingHabitDetailsSelectedState) {
      emit((state as CreatingHabitDetailsSelectedState).copyWith(
          goalAmount: goalAmount,
          goalUnit: goalUnit,
          selectedWeekDays: selectedWeekDays,
          timeOfDayToRepeat: timeOfDayToRepeat));
    } else {
      emit(CreatingHabitDetailsSelectedState(
          goalAmount: habit.goalAmount,
          goalUnit: habit.goalUnit,
          selectedWeekDays: habit.selectedWeekDays,
          timeOfDayToRepeat: habit.timeOfDayToRepeat));
    }
  }

  //* update days selection based on frequency
  void updateDaysSelectionBasedOnFrequency(String frequency) {
    List<DayModel> selectedDayModels = [];

    if (frequency == "Daily") {
      // Create DayModel for all days
      for (int i = 0; i < 7; i++) {
        selectedDayModels.add(DayModel(
          dayName: weekDaysList[i],
          dayDate: DateTime.now().add(Duration(days: i)).toString(),
          isSelected: true,
        ));
      }
    } else if (frequency == "Weekly") {
      selectedDayModels = [];
    } else if (frequency == "Monthly") {
      int today = DateTime.now().weekday % 7;
      selectedDayModels.add(DayModel(
        dayName: weekDaysList[today],
        dayDate: DateTime.now().toString(),
        isSelected: true,
      ));
    }

    updateHabitDetails(null, null, selectedDayModels, null);
  }

  //* toggle day selection for weekly frequency
  void toggleDaySelection(int dayIndex) {
    if (state is CreatingHabitDetailsSelectedState) {
      final currentState = state as CreatingHabitDetailsSelectedState;
      List<DayModel> currentSelectedDays =
          List.from(currentState.selectedWeekDays);

      // Check if day is already selected
      int existingIndex = currentSelectedDays
          .indexWhere((dayModel) => dayModel.dayName == weekDaysList[dayIndex]);

      if (existingIndex != -1) {
        // Remove if already selected
        currentSelectedDays.removeAt(existingIndex);
      } else {
        // Add if not selected
        currentSelectedDays.add(DayModel(
          dayName: weekDaysList[dayIndex],
          dayDate: DateTime.now().add(Duration(days: dayIndex)).toString(),
          isSelected: true,
        ));
      }

      updateHabitDetails(null, null, currentSelectedDays, null);
    }
  }

  //* get selected days as boolean list
  List<bool> getSelectedDaysAsList(String frequency) {
    if (frequency == "Daily") {
      return List.filled(7, true);
    } else if (frequency == "Weekly") {
      if (state is CreatingHabitDetailsSelectedState) {
        final currentState = state as CreatingHabitDetailsSelectedState;
        List<bool> selected = List.filled(7, false);
        for (var dayModel in currentState.selectedWeekDays) {
          int index = weekDaysList.indexOf(dayModel.dayName);
          if (index != -1) selected[index] = true;
        }
        return selected;
      }
      return List.filled(7, false);
    } else if (frequency == "Monthly") {
      List<bool> selected = List.filled(7, false);
      int today = DateTime.now().weekday % 7;
      selected[today] = true;
      return selected;
    }
    return List.filled(7, false);
  }

  //* update quantity selection
  void updateQuantity(String quantity) {
    updateHabitDetails(quantity, null, null, null);
  }

  //* update unit selection
  void updateUnit(String unit) {
    updateHabitDetails(null, unit, null, null);
  }

  //* update frequency and corresponding days
  void updateFrequency(String frequency) {
    updateDaysSelectionBasedOnFrequency(frequency);
  }

  //* create Habit
  void createHabit() {
    CreateHabitService().createHabit(habit);
    emit(CreatingHabitSuccessState());
  }
}
