import 'package:minders/features/creating_habit/manger/models/day_model.dart';

class HabitModel {
  String title;
  String goalAmount;
  String goalUnit;
  List<DayModel> selectedWeekDays;
  int timeOfDayToRepeat;
  HabitModel({
    required this.title,
    required this.goalAmount,
    required this.goalUnit,
    required this.selectedWeekDays,
    required this.timeOfDayToRepeat,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'goalAmount': goalAmount,
      'goalUnit': goalUnit,
      'selectedWeekDays': selectedWeekDays,
      'timeOfDayToRepeat': timeOfDayToRepeat,
    };
  }
}
