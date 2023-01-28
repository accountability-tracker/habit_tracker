import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import "s_isar.dart";
import "../habit_enums.dart";

// TODO: IN-PROGRESS remove this file completey

class HabitYesOrNo {
  int id = -1;
  EHABITS type = EHABITS.uninitalized;
  String title = "";
  Color color = const Color.fromRGBO(3, 3, 3, 1.0);
  String question = "";
  String notes = "";

  HabitYesOrNo(int idArg, EHABITS typeArg, String titleArg, Color colorArg, String questionArg,
      String notesArg) {
    id = idArg;
    type = typeArg;
    title = titleArg;
    color = colorArg;
    question = questionArg;
    notes = notesArg;
  }

  String getTitle() {
    return title;
  }

  Color getColor() {
    return color;
  }

  String getQuestion() {
    return question;
  }

  String getNotes() {
    return notes;
  }
}

final habitsManagerProvider = StateNotifierProvider<HabitItemManager, List<dynamic>>((ref) {
  return HabitItemManager([
    HabitYesOrNo(1, EHABITS.yesOrNo, "Test 1", const Color.fromRGBO(75, 97, 43, 1.0), "A question",
        "Some notes"),
    HabitYesOrNo(1, EHABITS.yesOrNo, "Test 4", const Color.fromRGBO(125, 127, 83, 1.0),
        "A question for test 4", "Some notes for test 4")
  ]);

  // return HabitItemManager([]);
});

class HabitItemManager extends StateNotifier<List<dynamic>> {
  HabitItemManager([List<dynamic>? habits]) : super(habits ?? []);

  void addHabit(dynamic nh) {
    state = [...state, nh];
  }
}
