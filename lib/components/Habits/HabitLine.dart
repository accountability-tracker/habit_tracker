import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import "../../s_isar.dart";
import "../../entities/habit.dart";
import "package:habit_tracker/entities/habit_date.dart";

import 'package:habit_tracker/habit_enums.dart';

import '../../habits.dart';

import '../../HabitSpecificview/HabitSpecificview.dart';

import 'HabitYesOrNoToggle.dart';
import 'package:habit_tracker/components/habits/HabitMeasurableBlock.dart';

class HabitLine extends StatefulWidget {
  HabitLine({
      Key? key,
      required this.isar_service,
      required this.habit
  }) : super(key: key);

  final IsarService isar_service;

  // TODO(clearfeld): update this to work with other habit types
  // final Habit_YesOrNo habit;
  final Habit habit;

  @override
  _HabitLine createState() => _HabitLine();
}

class _HabitLine extends State<HabitLine> {

  var date = DateTime.now();
  var nd = [4, 3, 2, 1, 0];
  final dss = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String printDay(int dn) {
    return dss[dn - 1];
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Row(
        // mainAxisAlignment: spaceEvenly,

        children: <Widget>[

          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            alignment: Alignment.centerLeft,

            child: TextButton(
              child: Text(
                widget.habit.getTitle(),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Color(widget.habit.getColor())
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page_HabitSpecificView(
                      isar_service: widget.isar_service,
                      habit: widget.habit
                  )),
                );
              },
            ),
          ),

          // Spacer(),

          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            alignment: Alignment.centerRight,
            // padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),

            child: FutureBuilder<List<HabitDate>>(
              future: widget.isar_service.getHabitsDateLastSeven(widget.habit.id),
              builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {

                // print(snapshot);
                // print(snapshot.data);

                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.data!.length == 0) {
                    // print("0");

                    // TODO(clearfeld): move the date logic outside somewhere in global state
                    // currently dates are being generated per habit + static day line
                    // we shouldnt be doing o(n) but o(1) generations and just using the stored date values
                    List<int> x = [4, 3, 2, 1, 0];
                    final habits = x.mapIndexed((index, habit) {
                        // int hidx = habit.key;
                        // print(index);

                        if(widget.habit.type == E_HABITS.YES_OR_NO) {
                          return HabitYesOrNoToggle(
                            habit: widget.habit,
                            date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                            isar_service: widget.isar_service
                          );
                        } else if(widget.habit.type == E_HABITS.MEASURABLE) {
                          return HabitMeasurableBlock(
                            habit: widget.habit,
                            date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                            isar_service: widget.isar_service
                          );
                        } else {
                          // TODO: allow nulls and check and display an error if this is reached
                          return HabitYesOrNoToggle(
                            habit: widget.habit,
                            date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                            isar_service: widget.isar_service
                          );
                        }

                    }).toList();

                    return new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: habits
                    );

                    // return HabitYesOrNoToggle(
                    //   habit: widget.habit
                    // );
                  } else {

                    // read the snapshot data and put it with the assoicated date spot
                    List<dynamic> habitDates = [
                      date,
                      date.subtract(Duration(days: (1))),
                      date.subtract(Duration(days: (2))),
                      date.subtract(Duration(days: (3))),
                      date.subtract(Duration(days: (4))),
                    ];

                    // print(date);
                    final hdates = snapshot.data!.map((hd) { return hd; }).toList();

                    for(var i = 0; i < habitDates.length; ++i) {
                      // print("Idx - " + i.toString());
                      var hd = habitDates[i];
                      // print(habitDates[i]);
                      // habitDates[i] = "asd";
                      // print(habitDates[i]);

                      var found = false;

                      for(var h in snapshot.data!) {
                        final h_splitted = h.getDate().split('-');
                        // print(h_splitted[0]);
                        // print(h_splitted[1]);
                        // print(h_splitted[2]);

                        if(int.parse(h_splitted[2]) == hd.day) {
                          if(int.parse(h_splitted[1]) == hd.month) {
                            if(int.parse(h_splitted[0]) == hd.year) {
                              // print("Here");
                              // hd = h
                              habitDates[i] = h;
                              found = true;
                              break;
                            }
                          }
                        }
                      }

                      if(!found) {
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

                        if(widget.habit.type == E_HABITS.YES_OR_NO) {
                          return HabitYesOrNoToggle(
                            habitDate: habitDates[index],
                            habit: widget.habit,
                            date: date.subtract(Duration(days: (4 - x[index]))), // index - date.weekday + 1
                            isar_service: widget.isar_service
                          );
                        } else if(widget.habit.type == E_HABITS.MEASURABLE) {
                          return HabitMeasurableBlock(
                            habit: widget.habit,
                            date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                            isar_service: widget.isar_service
                          );
                        } else {
                          // TODO: allow nulls and check and display an error if this is reached
                          return HabitYesOrNoToggle(
                            habit: widget.habit,
                            date: date.subtract(Duration(days: (4 - x[index]))), // - date.weekday + 1
                            isar_service: widget.isar_service
                          );
                        }
                    }).toList();


                    return new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: habits
                    );

                    // return new Row(
                    //   children: <Widget>[
                    //     Text("Sug")
                    //   ],
                    // );
                  }
                }

                // if(snapshot.data! == null) {
                //   print("NULL");
                //   return HabitYesOrNoToggle(
                //     habit: widget.habit
                //   );
                // }

                // if(snapshot.hasData) {

                //   // date
                //   // print(snapshot.data);
                //   final habits = snapshot.data!.map((habit) {
                //       return HabitYesOrNoToggle(
                //         habit: widget.habit
                //       );
                //   }).toList();

                //   return new Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: habits
                //   );
                // } else {
                //   List<int> x = [5,4,3,2,1];
                //   final habits = x.map((habit) {
                //       return HabitYesOrNoToggle(
                //         habit: widget.habit
                //       );
                //   }).toList();

                //   return new Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: habits
                //   );
                // }

                return Text(
                  "Loading indacator...",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.red,
                  ),
                );
              },
            ),

            // for(var n in  nd)
            // HabitYesOrNoToggle(
            //   habit: widget.habit
            // ),

            // Column(
            //   children: <Widget>[
            //     Text(printDay(date.subtract(Duration(days: (4 - n))).weekday)),
            //     Text(date.subtract(Duration(days: (4 - n))).day.toString()),
            //   ],
            // ),

          ),

        ],
      ),
    );
  }
}
