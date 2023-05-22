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

    return Column(
      children: [
        Container(
          color: customColors.navbarBackground,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: (MediaQuery.of(context).size.width * 0.8) + 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var n in nd)
                      Column(
                        children: <Widget>[
                          Text(printDay(date.subtract(Duration(days: (4 - n))).weekday),
                              style: TextStyle(color: customColors.navbarSubText)),
                          Text(date.subtract(Duration(days: (4 - n))).day.toString(),
                              style: TextStyle(color: customColors.navbarSubText)),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(color: customColors.background, thickness: 4.0, height: 4),
      ],
    );
  }
}
