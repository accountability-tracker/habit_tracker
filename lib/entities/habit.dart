import 'package:flutter/material.dart';
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

  Habit() {}

  Habit.Full(
    E_HABITS type_arg,
    String title_arg,
    String color_arg,
    E_HABIT_FREQUENCY frequency_arg,
    int frequency_amount_arg,
    String? reminder_arg,
    String? question_arg,
    String? notes_arg,
  ) {
    type = type_arg;
    title = title_arg;
    color = color_arg;
    unit = null;
    target = null;
    frequency = frequency_arg;
    frequency_amount = frequency_amount_arg;
    reminder = reminder_arg;
    question = question_arg;
    notes = notes_arg;
    archived = null;
  }

  Habit.FullMeasurable(
    E_HABITS type_arg,
    String title_arg,
    String color_arg,
    String unit_arg,
    int target_arg,
    E_HABIT_FREQUENCY frequency_arg,
    int frequency_amount_arg,
    String? reminder_arg,
    String? question_arg,
    String? notes_arg
  ) {
    type = type_arg;
    title = title_arg;
    color = color_arg;
    unit = unit_arg;
    target = target_arg;
    frequency = frequency_arg;
    frequency_amount = frequency_amount_arg;
    reminder = reminder_arg;
    question = question_arg;
    notes = notes_arg;
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
    var c = color.substring(6, color.length - 1);
    // print(c);
    return int.parse(c);
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
