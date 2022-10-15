import "package:isar/isar.dart";

import 'package:flutter/material.dart';

import "../habit_enums.dart";

// import "../habits.dart";

part "habit.g.dart";


@Collection()
class Habit {
  Id id = Isar.autoIncrement;

  @enumerated
  late E_HABITS type;

  late String title;

  late String color;

  late String question;
  late String notes;

  Habit() {}

  Habit.Full(
    E_HABITS type,
    String title,
    String color,
    String question,
    String notes
  ) {
    this.type = type;
    this.title = title;
    this.color = color;
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
}
