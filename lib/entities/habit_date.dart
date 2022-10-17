import "package:isar/isar.dart";

part "habit_date.g.dart";

@Collection()
class HabitDate {
  Id id = Isar.autoIncrement;

  late int habit_id;

  late String date;

  late int value;

  HabitDate() {}

  HabitDate.Full(
    int habit_id,
    String date,
    int value
  ) {
    this.habit_id = habit_id;
    this.date = date;
    this.value = value;
  }

  String getDate() {
    return this.date;
  }

  int getValue() {
    return this.value;
  }
}
