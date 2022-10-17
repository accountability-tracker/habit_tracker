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
    int id,
    int habit_id,
    String date,
    int value
  ) {
    this.id = id;
    this.habit_id = habit_id;
    this.date = date;
    this.value = value;
  }

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

  void setValue(int i) {
    this.value = i;
  }
}
