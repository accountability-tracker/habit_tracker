import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';

class HabitVariablesOverviewBlock extends ConsumerStatefulWidget {
  const HabitVariablesOverviewBlock({
      super.key,
      required this.isarService,
      required this.habit
  });

  final IsarService isarService;

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

          const Text(
            "Overview",
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),

          const SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),

              const SizedBox(width: 16.0,),

              Text(
                widget.habit.getFrequency().toString()
              ),
            ],
          ),

          const SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              const Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),

              const SizedBox(width: 16.0,),

              Text(
                (widget.habit.getReminder() == null ||
                widget.habit.getReminder() == "") ? "OFF" : widget.habit.getReminder()
              ),
            ],
          ),

          const SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              const Icon(
                Icons.question_mark,
                color: Colors.white,
              ),

              const SizedBox(width: 16.0,),

              Text(
                (widget.habit.getQuestion() == null ||
                  widget.habit.getQuestion() == "")
                ? "N/A" : widget.habit.getQuestion(),
              ),
            ],
          ),

          const SizedBox(height: 16.0,),

          Row(
            children: <Widget>[

              const Icon(
                Icons.notes,
                color: Colors.white,
              ),

              const SizedBox(width: 16.0,),

              Text(
                (widget.habit.getNotes() == null ||
                  widget.habit.getNotes() == "")
                  ? "N/A" : widget.habit.getNotes(),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
