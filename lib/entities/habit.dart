import 'package:isar/isar.dart';

import 'package:habit_tracker/habit_enums.dart';

part "habit.g.dart";

enum EHABITFREQUENCY {
  everyDay,
  everyXDays,
  xTimesPerWeek,
  xTimesPerMonth,
  // CUSTOM
}

@Collection()
class Habit {
  Id id = Isar.autoIncrement;

  @enumerated
  late EHABITS type;

  late String title;

  late String color;

  @enumerated
  late EHABITFREQUENCY frequency;
  late int frequencyAmount;
  // late int frequency_out_of_days;

  late String? unit;
  late int? target;

  late String? reminder; // Time

  late String? question;
  late String? notes;

  late bool? archived;

  Habit();

  Habit.full(
    EHABITS typeArg,
    String titleArg,
    String colorArg,
    EHABITFREQUENCY frequencyArg,
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
    frequencyAmount = frequencyAmountArg;
    reminder = reminderArg;
    question = questionArg;
    notes = notesArg;
    archived = null;
  }

  Habit.fullMeasurable(
      EHABITS typeArg,
      String titleArg,
      String colorArg,
      String unitArg,
      int targetArg,
      EHABITFREQUENCY frequencyArg,
      int frequencyAmountArg,
      String? reminderArg,
      String? questionArg,
      String? notesArg) {
    type = typeArg;
    title = titleArg;
    color = colorArg;
    unit = unitArg;
    target = targetArg;
    frequency = frequencyArg;
    frequencyAmount = frequencyAmountArg;
    reminder = reminderArg;
    question = questionArg;
    notes = notesArg;
    archived = null;
  }

  EHABITS getType() {
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

  EHABITFREQUENCY getFrequency() {
    return frequency;
  }

  String getFrequencyName() {
    switch (frequency) {
      case EHABITFREQUENCY.everyDay:
        return 'Every Day';
      case EHABITFREQUENCY.everyXDays:
        return 'Every $frequencyAmount Days';
      case EHABITFREQUENCY.xTimesPerMonth:
        return '$frequencyAmount Times a Month';
      case EHABITFREQUENCY.xTimesPerWeek:
        return '$frequencyAmount Times a Week';
    }
  }

  int getFrequencyAmount() {
    return frequencyAmount;
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

  bool isArchived() {
    return !(archived == null || archived == false);
  }
}
