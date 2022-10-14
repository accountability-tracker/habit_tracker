import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../habits.dart';

import '../../HabitSpecificview/HabitSpecificview.dart';

class HabitLine extends StatefulWidget {
  HabitLine({Key? key, required this.habit}) : super(key: key);

  // TODO(clearfeld): update this to work with other habit types
  final Habit_YesOrNo habit;

  @override
  _HabitLine createState() => _HabitLine();
}

class _HabitLine extends State<HabitLine> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: TextButton(
        child: Text(
          widget.habit.getTitle(),
          style: TextStyle(
            fontSize: 24.0,
            color: widget.habit.getColor()
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page_HabitSpecificView(
                habit: widget.habit
            )),
          );
        },
      ),
    );
  }
}