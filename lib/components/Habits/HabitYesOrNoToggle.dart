import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import "../../s_isar.dart";
import "../../entities/habit.dart";
import "../../habit_enums.dart";

import '../../habits.dart';

class HabitYesOrNoToggle extends StatefulWidget {
  HabitYesOrNoToggle({
      Key? key, required this.habit
  }) : super(key: key);

  // TODO(clearfeld): update this to work with other habit types
  final Habit habit;

  @override
  _HabitYesOrNoToggle createState() => _HabitYesOrNoToggle();
}

class _HabitYesOrNoToggle extends State<HabitYesOrNoToggle> {

  bool toggled_on = false;

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: (
        toggled_on ? Icon(Icons.close) : Icon(Icons.check)
      ),
      color: Color(widget.habit.getColor()), // Colors.red,
      onPressed: (){
        var x = !toggled_on;
        setState(() {
          toggled_on = x;
        });
        //code to execute when this button is pressed
      }
    );
  }
}
