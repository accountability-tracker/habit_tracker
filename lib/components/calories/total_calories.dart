import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/theme.dart';

class TotalCaloriesBlock extends ConsumerStatefulWidget {
  const TotalCaloriesBlock(
      {super.key, required this.receivedCals, required this.totalCals, required this.burnedCals});

  final int receivedCals;
  final int totalCals;
  final int burnedCals;

  @override
  ConsumerState<TotalCaloriesBlock> createState() => _TotalCaloriesBlock();
}

class _TotalCaloriesBlock extends ConsumerState<TotalCaloriesBlock> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

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
      child: IntrinsicHeight(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const <Widget>[
                          Text(
                            "Received",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.receivedCals.toString(),
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " / ${widget.totalCals.toString()}",
                            style: const TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                          const Text(
                            "  cal",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Spent",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.burnedCals.toString(),
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "  cal",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  //CircularProgressIndicator(
                  //  value:(widget.receivedCals - widget.burnedCals) / widget.totalCals,
                  //  backgroundColor: Colors.white,
                  //),
                  SizedBox(
                    height: 200,
                    width: 200,
                    // child: SfRadialGauge(
                    //   axes: [
                    //     RadialAxis(
                    //       minimum: 0,
                    //       maximum: widget.totalCals.toDouble(),
                    //       annotations: <GaugeAnnotation>[
                    //         GaugeAnnotation(
                    //             widget: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                 children: [
                    //               const SizedBox(
                    //                 height: 55.0,
                    //               ),
                    //               Text(
                    //                 "Total",
                    //                 style: TextStyle(fontSize: 14, color: Colors.grey),
                    //               ),
                    //               const SizedBox(
                    //                 height: 5.0,
                    //               ),
                    //               Text(
                    //                 widget.totalCals.toString(),
                    //                 style: TextStyle(fontSize: 24),
                    //               ),
                    //               Text(
                    //                 "cal",
                    //                 style: TextStyle(fontSize: 14, color: Colors.grey),
                    //               ),
                    //               const SizedBox(
                    //                 height: 60.0,
                    //               ),
                    //             ]))
                    //       ],
                    //       showLabels: false,
                    //       showTicks: false,
                    //       startAngle: 270,
                    //       endAngle: 270,
                    //       ranges: [
                    //         GaugeRange(
                    //             startValue: 0,
                    //             endValue: (widget.receivedCals - widget.burnedCals).toDouble())
                    //       ],
                    //     )
                    //   ],
                    // ),
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
