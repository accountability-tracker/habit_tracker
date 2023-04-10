import 'package:isar/isar.dart';

// import 'package:habit_tracker/habit_enums.dart';

part "food.g.dart";

@Collection()
class Food {
  Id id = Isar.autoIncrement;

  late String title;

  // TODO:
  // calories
  // nutrients

  Food();

  Food.full(
    String titleArg,
  ) {
    title = titleArg;
  }

  String getTitle() {
    return title;
  }
}
