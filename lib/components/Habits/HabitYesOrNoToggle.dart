import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import "../../s_isar.dart";
import "../../entities/habit.dart";
import "package:habit_tracker/entities/habit_date.dart";
import "../../habit_enums.dart";

import '../../habits.dart';

class HabitYesOrNoToggle extends StatefulWidget {
  HabitYesOrNoToggle({
      Key? key,
      this.habitDate,
      required this.habit,
      required this.date,
      required this.isar_service
  }) : super(key: key);

  // TODO(clearfeld): update this to work with other habit types
  HabitDate? habitDate;
  final Habit habit;
  final DateTime date;
  final IsarService isar_service;

  @override
  _HabitYesOrNoToggle createState() => _HabitYesOrNoToggle();
}

class _HabitYesOrNoToggle extends State<HabitYesOrNoToggle> {

  bool toggled_on = false; // habitDate != null ?
  // (
  //   habitDate?.getValue() == 0 ? false : true
  // )
  // : false;

  @override
  Widget build(BuildContext context) {

    // TODO(clearfeld): fix this to update on clcik
    toggled_on = widget.habitDate != null ?
    (
      widget.habitDate?.getValue() == 0 ? false : true
    )
    : false;

    return Column(
      children: <Widget>[
        IconButton(
          icon: (
            toggled_on ? Icon(Icons.check) : Icon(Icons.close)
          ),
          color: Color(widget.habit.getColor()), // Colors.red,
          onPressed: () {
            var x = !toggled_on;
            setState(() {
                toggled_on = x;
            });

            // print(widget.date);
            // print(widget.date.year);
            // print(widget.date.month);
            // print(widget.date.day);

            if(widget.habitDate == null) {
              // widget.habitDate =
              widget.isar_service.putHabitDate(
                HabitDate.Full(
                  widget.habit.id,
                  '${widget.date.year}-${widget.date.month}-${widget.date.day}',
                  x ? 1 : 0
                )
              );
            }
            //code to execute when this button is pressed
          }
        ),

        Text(widget.date.day.toString())
      ],
    );
  }
}
