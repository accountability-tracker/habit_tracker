import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:habit_tracker/data_notifier.dart';
import 'package:habit_tracker/habit_enums.dart';
import 'package:habit_tracker/page_habit_specific_view/page_habit_specific_view.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/components/progress_bar.dart';
// import 'package:habit_tracker/theme.dart';
import 'package:intl/intl.dart';

class HabitBar extends ConsumerStatefulWidget {
  const HabitBar(
      {Key? key, required this.isarService, required this.habit, required this.updateFunction})
      : super(key: key);

  final IsarService isarService;

  // TODO(clearfeld): update this to work with other habit types
  // final Habit_YesOrNo habit;
  final Habit habit;
  final Function(dynamic) updateFunction;

  @override
  ConsumerState<HabitBar> createState() => _HabitBar();
}

class _HabitBar extends ConsumerState<HabitBar> {
  late Future<List<HabitDate>>? fHabitDates;

  var date = DateTime.now();
  var nd = [4, 3, 2, 1, 0];
  final dss = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  void initState() {
    super.initState();
    // ref.read(habitsManagerProvider);

    loadHabits();
  }

  void loadHabits() {
    setState(() => {
          fHabitDates = widget.habit.getFrequency() == EHABITFREQUENCY.xTimesPerMonth
              ? widget.isarService.getHabitsDateCurrentMonth(
                  DateFormat('y-M').format(DateTime.now()), widget.habit.id)
              : widget.isarService.getHabitsDateLastSeven(widget.habit.id)
        });
  }

  String printDay(int dn) {
    return dss[dn - 1];
  }

  @override
  Widget build(BuildContext context) {
    // LoadHabits();

    return Row(
      children: <Widget>[
        // Spacer(),
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerRight,
            // padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0), customColors

            child: FutureBuilder<List<HabitDate>>(
              future: fHabitDates,
              builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isEmpty) {
                    int maxValue = 0;
                    String uom = "";

                    if (widget.habit.getFrequency() == EHABITFREQUENCY.everyDay) {
                      if (widget.habit.getType() == EHABITS.measurable) {
                        uom = "Today";
                        maxValue = widget.habit.getTarget()!;
                      } else {
                        uom = "Days";
                        maxValue = 7;
                      }
                    } else if (widget.habit.getFrequency() == EHABITFREQUENCY.everyXDays) {
                      uom = "Days";
                      maxValue = widget.habit.getFrequencyAmount();
                    } else if (widget.habit.getFrequency() == EHABITFREQUENCY.xTimesPerWeek) {
                      uom = "This Week";
                      if (widget.habit.getType() == EHABITS.measurable) {
                        maxValue = widget.habit.getTarget()!;
                      } else {
                        maxValue = widget.habit.getFrequencyAmount();
                      }
                    } else if (widget.habit.getFrequency() == EHABITFREQUENCY.xTimesPerMonth) {
                      uom = "This Month";
                      if (widget.habit.getType() == EHABITS.measurable) {
                        maxValue = widget.habit.getTarget()!;
                      } else {
                        maxValue = widget.habit.getFrequencyAmount();
                      }
                    }

                    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      ProgressBar(
                        habitName: widget.habit.getTitle(),
                        fullUnits: maxValue,
                        currentUnits: 0,
                        uom: uom,
                        color: widget.habit.getColor(),
                      ),
                    ]);
                  } else {
                    List<int> x = [];
                    List<dynamic> habitDates = [];
                    int maxValue = 1;
                    String uom = "";
                    if (widget.habit.getFrequency() == EHABITFREQUENCY.everyDay) {
                      if (widget.habit.getType() == EHABITS.measurable) {
                        uom = "Today";
                        maxValue = widget.habit.getTarget()!;
                        habitDates.add(date);
                      } else {
                        uom = "Days";
                        maxValue = 7;
                        for (var i = 0; i < 7; i++) {
                          x.add(i);
                          habitDates.add(date.subtract(Duration(days: (i))));
                        }
                      }
                    } else if (widget.habit.getFrequency() == EHABITFREQUENCY.everyXDays) {
                      uom = "Days";
                      maxValue = widget.habit.getFrequencyAmount();
                      for (var i = 0; i < widget.habit.getFrequencyAmount(); i++) {
                        x.add(i);
                        habitDates.add(date.subtract(Duration(days: (i))));
                      }
                    } else if (widget.habit.getFrequency() == EHABITFREQUENCY.xTimesPerWeek) {
                      uom = "This Week";
                      if (widget.habit.getType() == EHABITS.measurable) {
                        maxValue = widget.habit.getTarget()!;
                      } else {
                        maxValue = widget.habit.getFrequencyAmount();
                      }
                      for (var i = 0; i < date.weekday; i++) {
                        x.add(i);
                        habitDates.add(date.subtract(Duration(days: (i))));
                      }
                    } else if (widget.habit.getFrequency() == EHABITFREQUENCY.xTimesPerMonth) {
                      uom = "This Month";
                      if (widget.habit.getType() == EHABITS.measurable) {
                        maxValue = widget.habit.getTarget()!;
                      } else {
                        maxValue = widget.habit.getFrequencyAmount();
                      }
                      for (var i = 0; i < date.day; i++) {
                        x.add(i);
                        habitDates.add(date.subtract(Duration(days: (i))));
                      }
                    }

                    int completedVal = 0;

                    for (var i = 0; i < habitDates.length; ++i) {
                      var hd = habitDates[i];

                      for (var h in snapshot.data!) {
                        final hSplitted = h.getDate().split('-');

                        if (int.parse(hSplitted[2]) == hd.day) {
                          if (int.parse(hSplitted[1]) == hd.month) {
                            if (int.parse(hSplitted[0]) == hd.year) {
                              completedVal += h.getValue();
                              break;
                            }
                          }
                        }
                      }
                    }

                    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      ProgressBar(
                        habitName: widget.habit.getTitle(),
                        fullUnits: maxValue,
                        currentUnits: completedVal,
                        uom: uom,
                        color: widget.habit.getColor(),
                      ),
                    ]);
                  }
                }

                return const Text(
                  "Loading indacator...",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PageHabitSpecificView(isarService: widget.isarService, habit: widget.habit)),
            ).then(widget.updateFunction);
          },
        ),
      ],
    );
  }
}
