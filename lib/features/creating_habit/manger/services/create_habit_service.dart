import 'package:hive/hive.dart';
import 'package:minders/features/creating_habit/manger/models/habit_model.dart';

class CreateHabitService {
  Future<void> createHabit(HabitModel habit) async {
    //* open hive box
    var box = await Hive.openBox('habits');
    //* add habit to hive box with key as DayName (Sun, Mon, Tue, Wed, Thu, Fri, Sat)
    for (var day in habit.selectedWeekDays) {
      box.put(day.dayName, habit);
    }
  }
}
