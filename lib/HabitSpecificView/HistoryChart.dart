import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/HabitSpecificView/HistoryBarChart.dart';

// import '../components/FlatDropdown.dart';

class HistoryChart extends ConsumerStatefulWidget {
  const HistoryChart({
      super.key,
      required this.isar_service,
      required this.habit
  });

  final IsarService isar_service;

  // TODO: eventually handle the other habit types besides yes or no
  final dynamic habit;

  @override
  _HistoryChart createState() => _HistoryChart();
}

class _HistoryChart extends ConsumerState<HistoryChart> {
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

          Row(
            children: <Widget>[
              Text(
                "History",
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),

              const Spacer(),

              Text(
                "Selector - Week",
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0,),

          FutureBuilder<List<HabitDate>>(
            future: widget.isar_service.getHabitsDateLastSeven(widget.habit.id),

            builder: (BuildContext context, AsyncSnapshot<List<HabitDate>> snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.done:

                var d = DateTime.now();
                var dstr = '${d.year}-${d.month}-';
                List<dynamic> x = [
                  dstr + (d.day).toString(),
                  dstr + (d.day - 1).toString(),
                  dstr + (d.day - 2).toString(),
                  dstr + (d.day - 3).toString(),
                  dstr + (d.day - 4).toString(),
                  dstr + (d.day - 5).toString(),
                  dstr + (d.day - 6).toString(),
                ];

                List<dynamic> xy = [];

                // List<dynamic> xyz = [
                //   {
                //     "date": dstr + (d.day).toString(),
                //     "object": null
                //   }
                // ];

                // print(xyz[0]["date"]);

                var habit_dates = snapshot.data;
                // print(habit_dates);
                if(habit_dates != null) {
                  // for(var v in habit_dates) {
                  //   print(v.getDate());
                  // }

                  // sort by date
                  habit_dates.sort((a, b) {
                      return a.getDate().compareTo(b.getDate());
                  });

                  var i = 0;
                  for(var p in x) {

                    var found = false;
                    for(var v in habit_dates) {
                      // print(v.getDate());

                      if(v.getDate() == p) {
                        xy.add({
                            "date": p,
                            "object": v
                        });
                        // xyz[i]["object"] = v;
                        found = true;
                      }
                    }

                    if(!found) {
                      // print("Here");
                      xy.add({
                          "date": p,
                          "object": null
                      });
                    }
                    i += 1;
                  }

                  // for(var v in xy) {
                  //   print(v.toString());
                  // }
                }

                return HistoryBarChart(
                  habit_dates: xy, // habit_dates
                );

                default:
                  return Text("Loading");
              }
            }
          ),

        ],
      ),
    );

  }
}
