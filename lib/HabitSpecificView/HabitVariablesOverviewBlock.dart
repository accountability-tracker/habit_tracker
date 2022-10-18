import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';

import 'package:habit_tracker/habits.dart';

import 'package:habit_tracker/components/FlatTextField.dart';
// import '../components/FlatDropdown.dart';

class HabitVariablesOverviewBlock extends ConsumerStatefulWidget {
  const HabitVariablesOverviewBlock({
      super.key,
      required this.isar_service,
      required this.habit
  });

  final IsarService isar_service;

  // TODO: eventually handle the other habit types besides yes or no
  final dynamic habit;

  @override
  _HabitVariablesOverviewBlock createState() => _HabitVariablesOverviewBlock();
}

class _HabitVariablesOverviewBlock extends ConsumerState<HabitVariablesOverviewBlock> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(
        8.0, 12.0, 8.0, 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[800],
        // boxShadow: [
        //   BoxShadow(color: Colors.green, spreadRadius: 3),
        // ],
      ),

      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[

          Text(
            "Overview",
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),

          SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),

              SizedBox(width: 16.0,),

              Text("test"),
            ],
          ),

          SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),

              SizedBox(width: 16.0,),

              Text("test"),
            ],
          ),

          SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              Icon(
                Icons.question_mark,
                color: Colors.white,
              ),

              SizedBox(width: 16.0,),

              Text(
                widget.habit.getQuestion() == null ? "N/A" : widget.habit.getQuestion(),
              ),
            ],
          ),

          SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              Icon(
                Icons.notes,
                color: Colors.white,
              ),

              SizedBox(width: 16.0,),

              Text(
                widget.habit.getNotes() == null ? "N/A" : widget.habit.getNotes(),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
