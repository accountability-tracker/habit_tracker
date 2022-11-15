import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/page_habit_statistics_view/page_habit_statistics_view.dart';
import 'package:habit_tracker/components/progress_bar.dart';
import 'package:intl/intl.dart';

class HabitBar extends StatefulWidget {
  HabitBar({
      Key? key,
      required this.isarService,
      required this.habit
  }) : super(key: key);

  final IsarService isarService;

  // TODO(clearfeld): update this to work with other habit types
  // final Habit_YesOrNo habit;
  final Habit habit;

  @override
  _HabitBar createState() => _HabitBar();
}

class _HabitBar extends State<HabitBar> {

  var date = DateTime.now();
  var nd = [4, 3, 2, 1, 0];
  final dss = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String printDay(int dn) {
    return dss[dn - 1];
  }

  @override
  Widget build(BuildContext context) {

    return Row(

        children: <Widget>[
          // Spacer(),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              // padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),

              child: FutureBuilder<List<HabitDate>>(
                future: widget.habit.getFrequency() == E_HABIT_FREQUENCY.X_TIMES_PER_MONTH ? 
                        widget.isarService.getHabitsDateCurrentMonth(DateFormat('y-M').format(DateTime.now()), widget.habit.id) :
                        widget.isarService.getHabitsDateLastSeven(widget.habit.id),
                builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.data!.isEmpty) {

                      int maxValue = 0;
                      String uom = "";

                      if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.EVERY_DAY) {
                        uom = "Days";
                        maxValue = 7;
                      } else if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.EVERY_X_DAYS) {
                        uom = "Days";
                        maxValue = widget.habit.getFrequencyAmount();
                      } else if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.X_TIMES_PER_WEEK) {
                        uom = "This Week";
                        maxValue = 7;
                      } else if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.X_TIMES_PER_MONTH) {
                        // Get the number of days in the current month.
                        uom = "This Month";
                        DateTime now = DateTime.now();
                        DateTime lastDayOfMonth = DateTime(now.year, now.month+1, 0);
                        maxValue = lastDayOfMonth.day;
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [ProgressBar(
                            habitName: widget.habit.getTitle(),
                            fullUnits: maxValue,
                            currentUnits: 0,
                            uom: uom,
                            color: widget.habit.getColor(),
                          ),
                        ]
                      );

                    } else {
                      List<int> x = [];
                      List<dynamic> habitDates = [];
                      int maxValue = 1;
                      String uom = "";
                      if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.EVERY_DAY) {
                        uom = "Days";
                        maxValue = 7;
                        for (var i=0; i<7; i++) {
                          x.add(i);
                          habitDates.add(date.subtract(Duration(days: (i))));
                        }
                      } else if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.EVERY_X_DAYS) {
                        uom = "Days";
                        maxValue = widget.habit.getFrequencyAmount();
                        for (var i=0; i<widget.habit.getFrequencyAmount(); i++) {
                          x.add(i);
                          habitDates.add(date.subtract(Duration(days: (i))));
                        }
                      } else if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.X_TIMES_PER_WEEK) {
                        uom = "This Week";
                        maxValue = widget.habit.getFrequencyAmount();
                        for (var i=0; i<date.weekday; i++) {
                          x.add(i);
                          habitDates.add(date.subtract(Duration(days: (i))));
                        }
                      } else if (widget.habit.getFrequency() == E_HABIT_FREQUENCY.X_TIMES_PER_MONTH) {
                        uom = "This Month";
                        for (var i=0; i<date.day; i++) {
                          x.add(i);
                          habitDates.add(date.subtract(Duration(days: (i))));
                        }
                        // Get the number of days in the current month.
                        DateTime now = new DateTime.now();
                        DateTime lastDayOfMonth = new DateTime(now.year, now.month+1, 0);
                        maxValue = widget.habit.getFrequencyAmount();
                      }

                      int completedVal = 0;

                      for(var i = 0; i < habitDates.length; ++i) {
                        var hd = habitDates[i];

                        for(var h in snapshot.data!) {
                          final hSplitted = h.getDate().split('-');

                          if(int.parse(hSplitted[2]) == hd.day) {
                            if(int.parse(hSplitted[1]) == hd.month) {
                              if(int.parse(hSplitted[0]) == hd.year) {
                                completedVal += h.getValue();
                                break;
                              }
                            }
                          }
                        }
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [ProgressBar(
                            habitName: widget.habit.getTitle(),
                            fullUnits: maxValue,
                            currentUnits: completedVal,
                            uom: uom,
                            color: widget.habit.getColor(),
                          ),
                        ]
                      );
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
                  MaterialPageRoute(builder: (context) => PageHabitStatisticsView(
                      isarService: widget.isarService,
                      habit: widget.habit
                  )),
                );
            },
          ),
        ],
    );
  }
}
