import 'package:isar/isar.dart';

// import 'package:habit_tracker/habit_enums.dart';

part "meal.g.dart";

@Collection()
class Meal {
  Id id = Isar.autoIncrement;

  late String title;
  // TODO: array of food items

  Meal();

  Meal.full(
    String titleArg,
  ) {
    title = titleArg;
  }

  String getTitle() {
    return title;
  }
}
