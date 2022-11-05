import 'package:isar/isar.dart';

import 'package:habit_tracker/habit_enums.dart';

part "habit.g.dart";

enum E_HABIT_FREQUENCY {
  EVERY_DAY,
  EVERY_X_DAYS,
  X_TIMES_PER_WEEK,
  X_TIMES_PER_MONTH,
  // CUSTOM
}

@Collection()
class Habit {
  Id id = Isar.autoIncrement;

  @enumerated
  late E_HABITS type;

  late String title;

  late String color;

  @enumerated
  late E_HABIT_FREQUENCY frequency;
  late int frequency_amount;
  // late int frequency_out_of_days;

  late String? unit;
  late int? target;

  late String? reminder; // Time

  late String? question;
  late String? notes;

  late bool? archived;

  Habit();

  Habit.Full(
    E_HABITS typeArg,
    String titleArg,
    String colorArg,
    E_HABIT_FREQUENCY frequencyArg,
    int frequencyAmountArg,
    String? reminderArg,
    String? questionArg,
    String? notesArg,
  ) {
    type = typeArg;
    title = titleArg;
    color = colorArg;
    unit = null;
    target = null;
    frequency = frequencyArg;
    frequency_amount = frequencyAmountArg;
    reminder = reminderArg;
    question = questionArg;
    notes = notesArg;
    archived = null;
  }

  Habit.FullMeasurable(
    E_HABITS typeArg,
    String titleArg,
    String colorArg,
    String unitArg,
    int targetArg,
    E_HABIT_FREQUENCY frequencyArg,
    int frequencyAmountArg,
    String? reminderArg,
    String? questionArg,
    String? notesArg
  ) {
    type = typeArg;
    title = titleArg;
    color = colorArg;
    unit = unitArg;
    target = targetArg;
    frequency = frequencyArg;
    frequency_amount = frequencyAmountArg;
    reminder = reminderArg;
    question = questionArg;
    notes = notesArg;
    archived = null;
  }

  E_HABITS getType() {
    return type;
  }

  String getTitle() {
    return title;
  }

  int getColor() {
    // print(this.color);
    // final c =
    // var c = color.substring(6, color.length - 1);
    // print(c);
    return int.parse(color);
  }

  E_HABIT_FREQUENCY getFrequency() {
    return frequency;
  }

  int getFrequencyAmount() {
    return frequency_amount;
  }

  String? getReminder() {
    return reminder;
  }

  String? getQuestion() {
    return question;
  }

  String? getUnit() {
    return unit;
  }

  int? getTarget() {
    return target;
  }

  String? getNotes() {
    return notes;
  }

  bool IsArchived() {
    return !(archived == null || archived == false);
  }
}
