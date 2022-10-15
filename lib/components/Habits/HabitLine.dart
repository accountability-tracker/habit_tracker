import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../habits.dart';

import '../../HabitSpecificview/HabitSpecificview.dart';

import 'HabitYesOrNoToggle.dart';

class HabitLine extends StatefulWidget {
  HabitLine({Key? key, required this.habit}) : super(key: key);

  // TODO(clearfeld): update this to work with other habit types
  final Habit_YesOrNo habit;

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
                  color: widget.habit.getColor()
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page_HabitSpecificView(
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

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                for(var n in  nd)
                HabitYesOrNoToggle(
                  habit: widget.habit
                ),

                // Column(
                //   children: <Widget>[
                //     Text(printDay(date.subtract(Duration(days: (4 - n))).weekday)),
                //     Text(date.subtract(Duration(days: (4 - n))).day.toString()),
                //   ],
                // ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
