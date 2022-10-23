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
      required this.isarService
  });

  final IsarService isarService;

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
        const FiveDayLine(),

        Expanded(
          child: SingleChildScrollView(
            // onReorder: (int oldIndex, int newIndex) {},

            child:
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[

                FutureBuilder<List<Habit>>(
                  future: widget.isarService.getAllHabits(),
                  builder: (context, AsyncSnapshot<List<Habit>> snapshot) {

                    if(snapshot.hasData) {
                      // print(snapshot.data);
                      final habits = snapshot.data!.map((habit) {
                          if(habit.IsArchived()) {
                            // print(" - " + habit.IsArchived().toString());
                            return const SizedBox();
                          }

                          return Container(
                            color: const Color.fromRGBO(31, 31, 31, 1.0),
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(2.0),
                            padding: const EdgeInsets.all(8.0),
                            child: HabitLine(
                              isarService: widget.isarService,
                              habit: habit
                            ),
                          );
                      }).toList();

                      return Column(children: habits);
                    }

                    return const Text(
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

        const ProgressBar(
          habitName: "Worked on Flutter",
          fullUnits: 5,
          currentUnits: 2,
          uom: "Days",
        ),

      ],
    );
  }
}
