import 'package:minders/core/services/firestore_service.dart';
import 'package:minders/features/creating_habit/manger/models/habit_model.dart';

class CreateHabitService {
  Future<void> createHabit(HabitModel habit) async {
    FirestoreService().create(collection: 'habits', data: habit.toJson());

    // //* open hive box
    // var box = await Hive.openBox('habits');
    // //* add habit to hive box with key as DayName (Sun, Mon, Tue, Wed, Thu, Fri, Sat)
    // for (var day in habit.selectedWeekDays) {
    //   box.put(day.dayName, habit);
    // }
  }
}
