import 'package:equatable/equatable.dart';
import 'package:minders/features/creating_habit/manger/models/day_model.dart';
import 'package:minders/features/creating_habit/manger/models/habit_model.dart';

abstract class CreatingHabitStates extends Equatable {}

class CreatingHabitInitialState extends CreatingHabitStates {
  @override
  List<Object?> get props => [];
}

//* state for select habit title
class CreatingHabitTitleSelectedState extends CreatingHabitStates {
  @override
  List<Object?> get props => [habit];
  final HabitModel habit;
  CreatingHabitTitleSelectedState({required this.habit});
}

//* Select habit's details (goal amount, goal unit, selected week days, time of day to repeat)
class CreatingHabitDetailsSelectedState extends CreatingHabitStates {
  @override
  List<Object?> get props =>
      [goalAmount, goalUnit, selectedWeekDays, timeOfDayToRepeat];
  final String goalAmount;
  final String goalUnit;
  final List<DayModel> selectedWeekDays;
  final int timeOfDayToRepeat;


  CreatingHabitDetailsSelectedState({
    required this.goalAmount,
    required this.goalUnit,
    required this.selectedWeekDays,
    required this.timeOfDayToRepeat,
  });

  CreatingHabitDetailsSelectedState copyWith({
    String? goalAmount,
    String? goalUnit,
    List<DayModel>? selectedWeekDays,
    int? timeOfDayToRepeat,
  }) {
    return CreatingHabitDetailsSelectedState(
      goalAmount: goalAmount ?? this.goalAmount,
      goalUnit: goalUnit ?? this.goalUnit,
      selectedWeekDays: selectedWeekDays ?? this.selectedWeekDays,
      timeOfDayToRepeat: timeOfDayToRepeat ?? this.timeOfDayToRepeat,
    );
  }
}

//* Create habit success
class CreatingHabitSuccessState extends CreatingHabitStates {
  @override
  List<Object?> get props => [];
}
