import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RadialProgressBlock extends ConsumerStatefulWidget {
  const RadialProgressBlock({super.key,
                             required this.name,
                             required this.receivedNu,
                             required this.totalNu,
                             required this.unit,
                             required this.progressColor,
                             required this.radius,
                             required this.textSize,
                             required this.titleSize});

  final String name;
  final int receivedNu;
  final int totalNu;
  final String unit;
  final Color progressColor;
  final double radius;
  final double textSize;
  final double titleSize;

  @override
  ConsumerState<RadialProgressBlock> createState() => _RadialProgressBlock();
}

class _RadialProgressBlock extends ConsumerState<RadialProgressBlock> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    double progress = widget.receivedNu / widget.totalNu;
    if (progress > 1.0) {
      progress = 1.0;
    }

    int progressText = (progress * 100).toInt();
    return Container(
      padding: const EdgeInsets.fromLTRB(
        8.0,
        12.0,
        8.0,
        12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: customColors.backgroundCompliment,
        // boxShadow: [
        //   BoxShadow(color: Colors.green, spreadRadius: 3),
        // ],
      ),
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
                  CircularPercentIndicator(
                    radius: widget.radius,
                    lineWidth: 10.0,
                    backgroundWidth: 6.0,
                    animation: true,
                    percent: progress,
                    center: Text(
                      "$progressText%",
                      style: TextStyle(fontSize: widget.titleSize),
                    ),
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            SizedBox(
                              width: widget.titleSize * 5,
                              height: widget.titleSize * 2.5,
                              child: Text(widget.name, textAlign: TextAlign.center, style: TextStyle(fontSize: widget.titleSize, color: customColors.textColor), overflow: TextOverflow.ellipsis, maxLines: 2,),
                            ),
                            //Row(children: [
                            //  Text(widget.name, style: TextStyle(fontSize: widget.titleSize, color: customColors.textColor),)
                            //]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text(widget.receivedNu.toString(), style: TextStyle(fontSize: widget.textSize, color: customColors.textColor),),
                                        Text("  /  ${widget.totalNu}", style: TextStyle(fontSize: widget.textSize, color: customColors.textColorSecondary),),
                                        Text(" ${widget.unit}", style: TextStyle(fontSize: widget.textSize, color: customColors.textColorSecondary),)
                                        ],
                            ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ],
                        )
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: widget.progressColor,
                    backgroundColor: customColors.textColorSecondary!,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}
