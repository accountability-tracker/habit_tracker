import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/page_habit_specific_view/history_bar_chart.dart';

// import '../components/FlatDropdown.dart';

class HistoryChart extends ConsumerStatefulWidget {
  const HistoryChart({
      super.key,
      required this.isarService,
      required this.habit
  });

  final IsarService isarService;

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
              const Text(
                "History",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),

              const Spacer(),

              const Text(
                "Selector - Week",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0,),

          FutureBuilder<List<HabitDate>>(
            future: widget.isarService.getHabitsDateLastSeven(widget.habit.id),

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

                var habitDates = snapshot.data;
                if(habitDates != null) {

                  // sort by date
                  habitDates.sort((a, b) {
                      return a.getDate().compareTo(b.getDate());
                  });

                  for(var p in x) {
                    var found = false;
                    for(var v in habitDates) {

                      if(v.getDate() == p) {
                        xy.add({
                            "date": p,
                            "object": v
                        });
                        found = true;
                      }
                    }

                    if(!found) {
                      xy.add({
                          "date": p,
                          "object": null
                      });
                    }
                  }
                }

                return HistoryBarChart(
                  habitDates: xy, // habit_dates
                );

                default:
                  return const Text("Loading");
              }
            }
          ),

        ],
      ),
    );

  }
}
