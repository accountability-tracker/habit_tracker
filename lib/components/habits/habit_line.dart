import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/page_habit_specific_view/page_habit_specific_view.dart';

import 'package:habit_tracker/components/habits/habit_yes_or_no_toggle.dart';
import 'package:habit_tracker/components/habits/habit_measurable_block.dart';
import 'package:habit_tracker/theme.dart';

class HabitLine extends StatefulWidget {
  const HabitLine(
      {Key? key, required this.isarService, required this.habit, required this.updateFunction})
      : super(key: key);

  final IsarService isarService;

  // TODO(clearfeld): update this to work with other habit types
  // final Habit_YesOrNo habit;
  final Habit habit;
  final Function(dynamic) updateFunction;

  @override
  State<HabitLine> createState() => _HabitLine();
}

class _HabitLine extends State<HabitLine> {
  var date = DateTime.now();
  var nd = [4, 3, 2, 1, 0];
  final dss = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  late Future<List<HabitDate>>? fhabitDates;

  @override
  void initState() {
    super.initState();
    // ref.read(habitsManagerProvider);

    setState(() => {fhabitDates = widget.isarService.getHabitsDateLastSeven(widget.habit.id)});
  }

  String printDay(int dn) {
    return dss[dn - 1];
  }

  @override
  Widget build(BuildContext context) {
    var customColors = Theme.of(context).extension<CustomColors>()!;
    return Column(

      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                InkWell(
                  child: Text(
                    widget.habit.getTitle(),
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          PageHabitSpecificView(isarService: widget.isarService, habit: widget.habit)),
                    ).then(widget.updateFunction);
                  },
                )
              ],
            ),
            Column(
              children: [
              Text(
                widget.habit.getFrequencyName(),
                style: TextStyle(fontSize: 16.0, color: customColors.textColorSecondary),
              )
              ],
            )
          ],
        ),

        // Spacer(),
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: FutureBuilder<List<HabitDate>>(
                future: fhabitDates,
                builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      List<int> x = [4, 3, 2, 1, 0];
                      final habits = x.mapIndexed((index, habit) {
                        // int hidx = habit.key;
                        // print(index);

                        if (widget.habit.type == EHABITS.yesOrNo) {
                          return HabitYesOrNoToggle(
                              habit: widget.habit,
                              date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                              isarService: widget.isarService);
                        } else if (widget.habit.type == EHABITS.measurable) {
                          return HabitMeasurableBlock(
                              habit: widget.habit,
                              date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                              isarService: widget.isarService);
                        } else {
                          // TODO: allow nulls and check and display an error if this is reached
                          return HabitYesOrNoToggle(
                              habit: widget.habit,
                              date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                              isarService: widget.isarService);
                        }
                      }).toList();

                      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: habits); 
                    }
                    else {
                      // read the snapshot data and put it with the assoicated date spot
                      List<dynamic> habitDates = [
                        date,
                        date.subtract(const Duration(days: (1))),
                        date.subtract(const Duration(days: (2))),
                        date.subtract(const Duration(days: (3))),
                        date.subtract(const Duration(days: (4))),
                      ];

                      // print(date);
                      // final hdates = snapshot.data!.map((hd) { return hd; }).toList();

                      for (var i = 0; i < habitDates.length; ++i) {
                        // print("Idx - " + i.toString());
                        var hd = habitDates[i];
                        // print(habitDates[i]);
                        // habitDates[i] = "asd";
                        // print(habitDates[i]);

                        var found = false;

                        for (var h in snapshot.data!) {
                          final hSplitted = h.getDate().split('-');
                          // print(h_splitted[0]);
                          // print(h_splitted[1]);
                          // print(h_splitted[2]);

                          if (int.parse(hSplitted[2]) == hd.day) {
                            if (int.parse(hSplitted[1]) == hd.month) {
                              if (int.parse(hSplitted[0]) == hd.year) {
                                // print("Here");
                                // hd = h
                                habitDates[i] = h;
                                found = true;
                                break;
                              }
                            }
                          }
                        }

                        if (!found) {
                          habitDates[i] = null;
                        }
                      }

                      // for(var i = 0; i < habitDates.length; ++i) {
                      //   print("Idx - " + i.toString());
                      //   print(habitDates[i]);
                      //   // habitDates[i] = "asd";
                      //   // print(habitDates[i]);
                      // }

                      // return Text("test");

                      List<int> x = [4, 3, 2, 1, 0];
                      final habits = x.mapIndexed((index, habit) {
                        // int hidx = habit.key;
                        // print(index);

                        if (widget.habit.type == EHABITS.yesOrNo) {
                          return HabitYesOrNoToggle(
                              habitDate: habitDates[index],
                              habit: widget.habit,
                              date: date
                                  .subtract(Duration(days: (4 - x[index]))), // index - date.weekday + 1
                              isarService: widget.isarService);
                        } else if (widget.habit.type == EHABITS.measurable) {
                          return HabitMeasurableBlock(
                              habitDate: habitDates[index],
                              habit: widget.habit,
                              date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                              isarService: widget.isarService);
                        } else {
                          // TODO: allow nulls and check and display an error if this is reached
                          return HabitYesOrNoToggle(
                              habit: widget.habit,
                              date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                              isarService: widget.isarService);
                        }
                      }).toList();

                      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: habits);

                      // return new Row(
                      //   children: <Widget>[
                      //     Text("Sug")
                      //   ],
                      // );
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
              )
            )
          ],
    );
  }
}
