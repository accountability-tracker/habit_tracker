import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';

import 'package:habit_tracker/habits.dart';
import 'package:habit_tracker/components/habits/habit_line.dart';
import 'package:habit_tracker/components/five_day_line.dart';

import 'package:habit_tracker/components/progress_bar.dart';

class HabitListMain extends ConsumerStatefulWidget {
  const HabitListMain({
      super.key,
      required this.isar_service
  });

  final IsarService isar_service;

  @override
  _HabitListMain createState() => _HabitListMain();
}

class _HabitListMain extends ConsumerState<HabitListMain> {
  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);
  }


  @override
  Widget build(BuildContext context) {

    // final habits = await widget.isar_service.getAllHabits();

    // final him = ref.watch(habitsManagerProvider);

    // TODO: scrollview

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: <Widget>[
        FiveDayLine(),

        Expanded(
          child: SingleChildScrollView(
            // onReorder: (int oldIndex, int newIndex) {},

            child:
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[

                FutureBuilder<List<Habit>>(
                  future: widget.isar_service.getAllHabits(),
                  builder: (context, AsyncSnapshot<List<Habit>> snapshot) {

                    if(snapshot.hasData) {
                      // print(snapshot.data);
                      final habits = snapshot.data!.map((habit) {
                          if(habit.IsArchived()) {
                            // print(" - " + habit.IsArchived().toString());
                            return SizedBox();
                          }

                          return Container(
                            color: Color.fromRGBO(31, 31, 31, 1.0),
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(2.0),
                            padding: const EdgeInsets.all(8.0),
                            child: HabitLine(
                              isar_service: widget.isar_service,
                              habit: habit
                            ),
                          );
                      }).toList();

                      return new Column(children: habits);
                    }

                    return Text(
                      "Loading indacator..."
                    );
                  },
                ),
                // for(var habit in habits)
                // if(habit is Habit_YesOrNo) ...[
                //   Container(
                //     color: Color.fromRGBO(31, 31, 31, 1.0),
                //     width: MediaQuery.of(context).size.width,
                //     margin: const EdgeInsets.all(2.0),
                //     padding: const EdgeInsets.all(8.0),
                //     child: HabitLine(
                //       habit: habit
                //     ),
                //   ),
                // ]
              ],
            ),

            // );
          ),
        ),

        ProgressBar(
          habit_name: "Worked on Flutter",
          full_units: 5,
          current_units: 2,
          uom: "Days",
        ),
      ],
    );
  }
}
