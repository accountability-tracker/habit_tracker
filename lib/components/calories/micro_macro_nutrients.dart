import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/theme.dart';

class MicroMacroNutrientBlock extends ConsumerStatefulWidget {
  const MicroMacroNutrientBlock({super.key, required this.name, required this.receivedNu, required this.totalNu, required this.unit});

  final String name;
  final int receivedNu;
  final int totalNu;
  final String unit;

  @override
  ConsumerState<MicroMacroNutrientBlock> createState() => _MicroMacroNutrientBlock();
}

class _MicroMacroNutrientBlock extends ConsumerState<MicroMacroNutrientBlock> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    int progress = (((widget.receivedNu) / widget.totalNu) * 100).toInt();

    return Container(
      padding: const EdgeInsets.fromLTRB(
        8.0,
        12.0,
        8.0,
        12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: customColors.backgroundCompliment,
        // boxShadow: [
        //   BoxShadow(color: Colors.green, spreadRadius: 3),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(children: [Text(widget.name, style: const TextStyle(fontSize: 18, color: Colors.grey),)]),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [Text(widget.receivedNu.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                   Text("  /  ${widget.totalNu}", style: const TextStyle(fontSize: 24, color: Colors.grey),),
                                   Text(" ${widget.unit}", style: const TextStyle(fontSize: 18, color: Colors.grey),)
                                  ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  //CircularProgressIndicator(
                  //  value:(widget.receivedCals - widget.burnedCals) / widget.totalCals,
                  //  backgroundColor: Colors.white,
                  //),
                  SizedBox(
                    height: 130,
                    width: 130,
                    // child: SfRadialGauge(
                    //   axes: [
                    //     RadialAxis(
                    //       minimum: 0,
                    //       maximum: widget.totalNu.toDouble(),
                    //       annotations: <GaugeAnnotation>[
                    //         GaugeAnnotation(
                    //           widget: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             children: [
                    //               Text('$progress%',
                    //                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                    //                   ),
                    //             ]
                    //           )
                    //         )
                    //       ],
                    //       showLabels: false,
                    //       showTicks: false,
                    //       startAngle: 270,
                    //       endAngle: 270,
                    //       ranges: [
                    //         GaugeRange(startValue: 0, endValue: (widget.receivedNu).toDouble(),
                    //                    gradient: const SweepGradient(colors: [Colors.blue, Colors.lightBlue]),
                    //         )
                    //       ],
                    //       //axisLineStyle: AxisLineStyle(color: Colors.blue),
                    //     )
                    //   ],
                    // ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      )
    );
  }
}
