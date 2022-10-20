import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "../s_isar.dart";
import "../entities/habit.dart";

import '../habits.dart';
import './Habits/HabitLine.dart';
import './FiveDayLine.dart';

import 'package:habit_tracker/components/ProgressBar.dart';

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
