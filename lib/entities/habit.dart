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

  late String? reminderTime; // Time
  late String? reminderMessage;

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
    String? reminderTimeArg,
    String? reminderMessageArg,
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
    reminderTime = reminderTimeArg;
    reminderMessage = reminderMessageArg;
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
      String? reminderTimeArg,
      String? reminderMessageArg,
      String? questionArg,
      String? notesArg) {
    type = typeArg;
    title = titleArg;
    color = colorArg;
    unit = unitArg;
    target = targetArg;
    frequency = frequencyArg;
    frequencyAmount = frequencyAmountArg;
    reminderTime = reminderTimeArg;
    reminderMessage = reminderMessageArg;
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

  String getColorString() {
    return color;
  }

  EHABITFREQUENCY getFrequency() {
    return frequency;
  }

  String getFrequencyName() {
    String unit = getUnit() ?? 'Times';
    String fa = getFrequencyAmount().toString();
    if (getTarget() != null) {
      fa = getTarget().toString();
    }
    switch (frequency) {
      case EHABITFREQUENCY.everyDay:
        return 'Every Day';
      case EHABITFREQUENCY.everyXDays:
        return 'Every $fa Days';
      case EHABITFREQUENCY.xTimesPerMonth:
        return '$fa $unit a Month';
      case EHABITFREQUENCY.xTimesPerWeek:
        return '$fa $unit a Week';
    }
  }

  int getFrequencyAmount() {
    return frequencyAmount;
  }

  String? getReminderTime() {
    return reminderTime;
  }

  String? getReminderMessage() {
    return reminderMessage;
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
