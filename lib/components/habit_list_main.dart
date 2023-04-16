import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/data_notifier.dart';

import 'package:habit_tracker/theme.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';

import 'package:habit_tracker/habits.dart';
import 'package:habit_tracker/components/habits/habit_line.dart';
import 'package:habit_tracker/components/habits/habit_progress_bar.dart';
import 'package:habit_tracker/components/five_day_line.dart';

// import 'package:habit_tracker/components/progress_bar.dart';

class HabitListMain extends ConsumerStatefulWidget {
  const HabitListMain(
      {super.key,
      required this.isarService,
      required this.habitView,
      required this.updateFunction});

  final IsarService isarService;
  final String habitView;
  final Function(dynamic) updateFunction;

  @override
  ConsumerState<HabitListMain> createState() => _HabitListMain();
}

class _HabitListMain extends ConsumerState<HabitListMain> {
  late Future<List<Habit>>? fhabits;

  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);

    loadHabits();
  }

  @override
  void didUpdateWidget(HabitListMain oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (ref.watch(dataUpdate)) {
      loadHabits();
      Future(() {
        ref.read(dataUpdate.notifier).setUpdate();
      });
    }
  }

  void loadHabits() {
    setState(() => {fhabits = widget.isarService.getAllHabits()});
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    // final habits = await widget.isar_service.getAllHabits();

    // final him = ref.watch(habitsManagerProvider);

    // TODO: scrollview

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[

        Expanded(
          child: SingleChildScrollView(
            // onReorder: (int oldIndex, int newIndex) {},

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: const FiveDayLine(),
                ),
                FutureBuilder<List<Habit>>(
                  future: fhabits,
                  builder: (context, AsyncSnapshot<List<Habit>> snapshot) {
                    if (snapshot.hasData) {
                      if (widget.habitView == 'input') {
                        final habits = snapshot.data!.map((habit) {
                          if (habit.isArchived()) {
                            return const SizedBox();
                          }

                          return Container(
                            decoration: BoxDecoration(
                              color: customColors.backgroundCompliment!,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            // const Color.fromRGBO(31, 31, 31, 1.0),
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                            padding: const EdgeInsets.all(12.0),
                            child: HabitLine(
                                isarService: widget.isarService,
                                habit: habit,
                                updateFunction: widget.updateFunction),
                          );
                        }).toList();

                        return Column(children: habits);
                      } else {
                        final habits = snapshot.data!.map((habit) {
                          if (habit.isArchived()) {
                            return const SizedBox();
                          }

                          return Container(
                            color: customColors.backgroundCompliment,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: HabitBar(
                                isarService: widget.isarService,
                                habit: habit,
                                updateFunction: widget.updateFunction),
                          );
                        }).toList();

                        return Column(children: habits);
                      }
                    }

                    return const Text("Loading indacator...");
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
      ],
    );
  }
}
