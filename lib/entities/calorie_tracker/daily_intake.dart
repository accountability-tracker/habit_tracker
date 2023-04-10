import "package:isar/isar.dart";

part "daily_intake.g.dart";

@Collection()
class DailyIntake {
  Id id = Isar.autoIncrement;

  late String date;

  // TODO: meal array

  DailyIntake();

  DailyIntake.full(String dateArg) {
    date = dateArg;
  }

  String getDate() {
    return date;
  }
}
