import "package:isar/isar.dart";

part "habit_date.g.dart";

@Collection()
class HabitDate {
  Id id = Isar.autoIncrement;

  // add index
  late int habit_id;
  // add index
  late String date;

  late int value;

  HabitDate() {}

  HabitDate.FullWithId(
    int idArg,
    int habitIdArg,
    String dateArg,
    int valueArg
  ) {
    id = idArg;
    habit_id = habitIdArg;
    date = dateArg;
    value = valueArg;
  }

  HabitDate.Full(
    int habitIdArg,
    String dateArg,
    int valueArg
  ) {
    habit_id = habitIdArg;
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
