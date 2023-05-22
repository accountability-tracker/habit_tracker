import "package:isar/isar.dart";
import 'package:path_provider/path_provider.dart';

import "entities/meta.dart";
import "entities/habit.dart";
import "entities/habit_date.dart";

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final appDocDir = await getApplicationSupportDirectory();
      // print('App Doc path - $appDocDir.path');

      return await Isar.open([AppMetaInfoSchema, HabitSchema, HabitDateSchema],
          directory: appDocDir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  // App Meta Info Helpers
  Future<void> saveAppMetaInfo(AppMetaInfo appMetaInfoArg) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.appMetaInfos.putSync(appMetaInfoArg));
  }

  //Future<List<AppMetaInfo>> getAppMetaInfo() async {
  Future<AppMetaInfo?> getAppMetaInfo() async {
    final isar = await db;
    final res = await isar.appMetaInfos.where().idEqualTo(0).findAll();

    if (res.isEmpty) {
      return null;
    } else {
      return res.first;
    }
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

  Future<void> updateHabit(Habit? habitArg) async {
    if (habitArg != null) {
      final isar = await db;

      await isar.writeTxn(() async {
        await isar.habits.put(habitArg);
      });
    }
  }

  Future<void> changeHabitArchivedState(int habitIdArg, bool archivedStateArg) async {
    final isar = await db;

    await isar.writeTxn(() async {
      final habit = await isar.habits.get(habitIdArg);
      if (habit != null) {
        habit.archived = archivedStateArg;
        await isar.habits.put(habit);
      }
    });
  }

  // TODO(clearfeld): return bool and add error state if this isn't true
  // for now assuming true for testing and iteration purposes
  Future<void> deleteHabit(int habitIdArg) async {
    final isar = await db;
    await isar.writeTxn(() async {
      isar.habits.delete(habitIdArg);
    });
    await isar.writeTxn(() async {
      final habitDates = await isar.habitDates.filter().habitIdEqualTo(habitIdArg).findAll();
      for (var date in habitDates) {
        isar.habitDates.delete(date.id);
      }
    });
  }

  // Habit Date Helpers

  Future<List<HabitDate>> getHabitsDateLastSeven(int habitIdArg) async {
    final isar = await db;
    // return await isar.habitDates.where().findAll();

    // TODO(clearfeld): make this filter an actual week range on the dates
    return await isar.habitDates.filter().habitIdEqualTo(habitIdArg).limit(10).findAll();
  }

  Future<int> putHabitDate(HabitDate habitDate) async {
    final isar = await db;
    var x = isar.writeTxnSync<int>(() => isar.habitDates.putSync(habitDate));
    // TODO(clearfled): seems to be the item id which is good enough
    // needs more testing to confirm
    // cant find any additional info in the docs
    // probably should dive into the isar source and double check this at some point
    // print("Isar x = " + x.toString());
    return x;
  }

  Future<List<HabitDate>> getHabitsDateCurrentMonth(String date, [int habitIdArg = -1]) async {
    final isar = await db;

    if (habitIdArg == -1) {
      return await isar.habitDates.filter().dateContains(date).findAll();
    }
    return await isar.habitDates.filter().habitIdEqualTo(habitIdArg).dateContains(date).findAll();
  }

  Future<List<HabitDate>> getHabitsDateLastSelectedPeriod(int habitIdArg, String dateString) async {
    final isar = await db;
    return await isar.habitDates
        .filter()
        .habitIdEqualTo(habitIdArg)
        .dateGreaterThan(dateString)
        .findAll();
  }

  Future<List<HabitDate>> getHabitDate(int habitIdArg, String dateString) async {
    final isar = await db;
    return await isar.habitDates
        .filter()
        .habitIdEqualTo(habitIdArg)
        .dateEqualTo(dateString)
        .findAll();
  }

  Future<void> toggleHabitDate(HabitDate habitDate) async {
    if (habitDate != null) {
      final isar = await db;

      await isar.writeTxn(() async {
        await isar.habitDates.put(habitDate);
      });
    }
  }
}
