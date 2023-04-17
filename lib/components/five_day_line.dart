import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/theme.dart';

class FiveDayLine extends ConsumerStatefulWidget {
  const FiveDayLine({
    super.key,
  });

  @override
  ConsumerState<FiveDayLine> createState() => _FiveDayLine();
}

class _FiveDayLine extends ConsumerState<FiveDayLine> {
  @override
  void initState() {
    super.initState();
    // ref.read(habitsManagerProvider);
  }

  var date = DateTime.now();
  var nd = [4, 3, 2, 1, 0];

  final dss = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String printDay(int dn) {
    return dss[dn - 1];
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    // final him = ref.watch(habitsManagerProvider);

    return Container(
      color: customColors.navbarBackground,
      width: MediaQuery.of(context).size.width,
      //margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Spacer(),

          //Container(
          //  width: MediaQuery.of(context).size.width * 0.45,
          //),

          // Text(date.toString()),
          // Text(date.add(Duration(days: 1)).toString()),

          SizedBox(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            width: (MediaQuery.of(context).size.width * 0.8) + 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (var n in nd)
                  Column(
                    children: <Widget>[
                      Text(printDay(date.subtract(Duration(days: (4 - n))).weekday), style: TextStyle(color: customColors.textColorSecondary)),
                      Text(date.subtract(Duration(days: (4 - n))).day.toString(), style: TextStyle(color: customColors.textColorSecondary)),
                    ],
                  ),
              ],
            ),
          ),

          // Expanded(
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: Container(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: <Widget>[

          //           for(var n in  nd)
          //           Column(
          //             children: <Widget>[
          //               Text(printDay(date.subtract(Duration(days: (4 - n))).weekday)),
          //               Text(date.subtract(Duration(days: (4 - n))).day.toString()),
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
