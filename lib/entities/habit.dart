import "package:isar/isar.dart";

import 'package:flutter/material.dart';

import "../habit_enums.dart";

// import "../habits.dart";

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

  Habit() {}

  Habit.Full(
    E_HABITS type,
    String title,
    String color,
    E_HABIT_FREQUENCY frequency,
    int frequency_amount,
    String? reminder,
    String? question,
    String? notes
  ) {
    this.type = type;
    this.title = title;
    this.color = color;
    this.unit = null;
    this.target = null;
    this.frequency = frequency;
    this.frequency_amount = frequency_amount;
    this.reminder = reminder;
    this.question = question;
    this.notes = notes;
  }

  Habit.FullMeasurable(
    E_HABITS type,
    String title,
    String color,
    String unit,
    int target,
    E_HABIT_FREQUENCY frequency,
    int frequency_amount,
    String? reminder,
    String? question,
    String? notes
  ) {
    this.type = type;
    this.title = title;
    this.color = color;
    this.unit = unit;
    this.target = target;
    this.frequency = frequency;
    this.frequency_amount = frequency_amount;
    this.reminder = reminder;
    this.question = question;
    this.notes = notes;
  }

  String getTitle() {
    return this.title;
  }

  int getColor() {
    // print(this.color);
    // final c =
    var c = this.color.substring(6, this.color.length - 1);
    // print(c);
    return int.parse(c);
  }

  E_HABIT_FREQUENCY getFrequency() {
    return this.frequency;
  }

  int getFrequencyAmount() {
    return this.frequency_amount;
  }

  String? getReminder() {
    return this.reminder;
  }

  String? getQuestion() {
    return this.question;
  }

  String? getNotes() {
    return this.notes;
  }
}
