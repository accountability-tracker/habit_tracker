import "package:isar/isar.dart";
import 'package:path_provider/path_provider.dart';

import "entities/habit.dart";

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if(Isar.instanceNames.isEmpty) {
      final appDocDir = await getApplicationSupportDirectory();
      print('App Doc path - ' + appDocDir.path);

      return await Isar.open(
        [HabitSchema],
        directory: appDocDir.path,
        inspector: true
      );
    }

    return Future.value(Isar.getInstance());
  }

  // Habit helpers

  Future<void> saveHabit(Habit newHabit) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.habits.putSync(newHabit));
  }

  Future<List<Habit>> getAllHabits() async {
    final isar = await db;
    return await isar.habits.where().findAll();
  }

  // TODO(clearfeld): return bool and add error state if this isn't true
  // for now assuming true for testing and iteration purposes
  Future<void> deleteHabit(int habit_id_arg) async {
    final isar = await db;
    await isar.writeTxn(() async {
        isar.habits.delete(habit_id_arg);
    });
  }

  //

}
