import "package:isar/isar.dart";

part "habit_date.g.dart";

@Collection()
class HabitDate {
  Id id = Isar.autoIncrement;

  // add index
  late int habitId;
  // add index
  late String date;

  late int value;

  HabitDate();

  HabitDate.fullWithId(int idArg, int habitIdArg, String dateArg, int valueArg) {
    id = idArg;
    habitId = habitIdArg;
    date = dateArg;
    value = valueArg;
  }

  HabitDate.full(int habitIdArg, String dateArg, int valueArg) {
    habitId = habitIdArg;
    date = dateArg;
    value = valueArg;
  }

  String getDate() {
    return date;
  }

  int getValue() {
    return value;
  }

  void setValue(int i) {
    value = i;
  }
}
