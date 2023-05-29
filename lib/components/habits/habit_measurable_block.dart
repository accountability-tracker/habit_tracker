import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/entities/habit_date.dart';
import 'package:habit_tracker/theme.dart';
import 'package:habit_tracker/components/flat_textfield.dart';

class HabitMeasurableBlock extends StatefulWidget {
  HabitMeasurableBlock(
      {Key? key,
      this.habitDate,
      required this.habit,
      required this.date,
      required this.isarService})
      : super(key: key);

  // TODO(clearfeld): update this to work with other habit types
  HabitDate? habitDate;
  final Habit habit;
  final DateTime date;
  final IsarService isarService;

  @override
  State<HabitMeasurableBlock> createState() => _HabitMeasurableBlock();
}

class _HabitMeasurableBlock extends State<HabitMeasurableBlock> {
  // bool toggledOn = false; // habitDate != null ?
  // (
  //   habitDate?.getValue() == 0 ? false : true
  // )
  // : false;

  String valueText = "0";
  int currentValue = 0;

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(clearfeld): fix this to update on clcik
    // toggled_on = widget.habitDate != null ?
    // (
    //   widget.habitDate?.getValue() == 0 ? false : true
    // )
    // : false;
    final customColors = Theme.of(context).extension<CustomColors>()!;

    if (widget.habitDate != null && widget.habitDate?.getValue() != null) {
      valueText = widget.habitDate?.getValue().toString() ?? "0";
      currentValue = widget.habitDate?.getValue() ?? 0;
    }

    return Column(
      children: <Widget>[
        InkWell(
          child:
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 60,
              child: Text(
                valueText,
                style: TextStyle(
                  color: Color(widget.habit.getColor()), // Colors.red,
                  fontSize: 24.0,
                ),
              ),

            ),
          onTap: () async {
            // var initialValue = currentValue;
            var res = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Set a value!', textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: customColors.background,
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          child:FlatTextField(textController: textController, alignment: TextAlign.center),
                          width: 60,
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Got it'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormal!),
                            foregroundColor: MaterialStateColor.resolveWith((states) => customColors.textColor!),
                            surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                            overlayColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormalHover!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                            )
                          ),
                          onPressed: () {
                            if ((textController.text == '' ||
                                int.tryParse(textController.text) == null)) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      surfaceTintColor: Colors.transparent,
                                      backgroundColor: customColors.background,
                                      title: const Text('Please enter a valid number.'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: const <Widget>[],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            ElevatedButton(
                                              child: const Text('Okay'),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormal!),
                                                foregroundColor: MaterialStateColor.resolveWith((states) => customColors.textColor!),
                                                surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                                                overlayColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormalHover!),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  )
                                                )
                                              ),
                                              onPressed: () {
                                                // setState(() => currentValue = initialValue);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              // setState(() => currentValue = currentValue);
                              Navigator.of(context).pop({"set": true, "value": textController.text});
                            }
                          },
                        ),
                        SizedBox(width: 16,),
                        ElevatedButton(
                          child: Text('Cancel', style: TextStyle(color: customColors.textColorSecondary),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormal!),
                            foregroundColor: MaterialStateColor.resolveWith((states) => customColors.textColor!),
                            overlayColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormalHover!),
                            surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                            )
                          ),
                          onPressed: () {
                            // setState(() => currentValue = initialValue);
                            Navigator.of(context).pop({"set": false, "value": textController.text});
                          },
                        ),
                      ],
                    )
                  ],
                );
              }
            );

            if (res != null && res["set"]) {
              // print("Value - " + res["set"].toString());
              // print("Value - " + res["value"].toString());

              var x = int.parse(res["value"]);

              if (res["set"]) {
                setState(() {
                  currentValue = x;
                });

                // print(widget.date);
                // print(widget.date.year);
                // print(widget.date.month);
                // print(widget.date.day);

                if (widget.habitDate == null) {
                  widget.habitDate?.value = x;

                  // widget.habitDate =
                  var id = await widget.isarService.putHabitDate(HabitDate.full(widget.habit.id,
                      '${widget.date.year}-${widget.date.month}-${widget.date.day}', x));

                  widget.habitDate = HabitDate.fullWithId(id, widget.habit.id,
                      '${widget.date.year}-${widget.date.month}-${widget.date.day}', x);
                } else {
                  widget.habitDate?.value = x;
                  // var hd = widget.habitDate().. value: x ? 1 : 0;
                  // print(widget.habitDate);
                  var i = widget.habitDate?.id;
                  var hi = widget.habitDate?.habitId;
                  var d = widget.habitDate?.date;
                  var v = widget.habitDate?.value;

                  if (i != null && hi != null && d != null && v != null) {
                    widget.isarService.putHabitDate(HabitDate.fullWithId(i, hi, d, v));
                  }
                }
                //code to execute when this button is pressed
              }
            }
            else {
              textController.text = currentValue.toString();
            }
          },
        ),
        if (widget.habit.unit.toString() != "")
          Text(widget.habit.unit.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              )),
      ],
    );
  }
}
