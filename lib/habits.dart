import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import "s_isar.dart";
import "../habit_enums.dart";

class Habit_YesOrNo {
  int id = -1;
  E_HABITS type = E_HABITS.UNINITALIZED;
  String title = "";
  Color color = Color.fromRGBO(3, 3, 3, 1.0);
  String question = "";
  // TODO(clearfeld) frequency enum
  // TODO(clearfeld) reminder class
  String notes = "";

  // const Habit_YesOrNo({
  //     this.id,
  //     this.type,
  //     this.title,
  //     this.color
  // });

  Habit_YesOrNo(
    int id,
    E_HABITS type,
    String title,
    Color color,
    String question,
    String notes
  ) {
    this.id = id;
    this.type = type;
    this.title = title;
    this.color = color;
    this.question = question;
    this.notes = notes;
  }

  String getTitle() {
    return title;
  }

  Color getColor() {
    return color;
  }
}

final habitsManagerProvider = StateNotifierProvider<HabitItemManager, List<dynamic>>((ref) {
    return HabitItemManager([
        Habit_YesOrNo(
          1,
          E_HABITS.YES_OR_NO,
          "Test 1",
          Color.fromRGBO(75, 97, 43, 1.0),
          "A question",
          "Some notes"
        ),

        Habit_YesOrNo(
          1,
          E_HABITS.YES_OR_NO,
          "Test 4",
          Color.fromRGBO(125, 127, 83, 1.0),
          "A question for test 4",
          "Some notes for test 4"
        )
    ]);

    // return HabitItemManager([]);
});

class HabitItemManager extends StateNotifier<List<dynamic>> {
  HabitItemManager([List<dynamic>? habits]) : super(habits ?? []);

  void addHabit(dynamic nh) {
    state = [...state, nh];
  }
}
