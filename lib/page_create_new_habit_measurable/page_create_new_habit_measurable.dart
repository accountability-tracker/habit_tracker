import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/components/flat_date_picker.dart';
import 'package:habit_tracker/components/color_select.dart';
import 'package:habit_tracker/components/flat_switch.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/habits.dart';

import 'package:habit_tracker/components/flat_textfield.dart';
import 'package:habit_tracker/components/flat_dropdown.dart';

import 'package:habit_tracker/data_notifier.dart';
import 'package:habit_tracker/theme.dart';

// TODO(clearfeld): move this into its own file and make it an enum instead
const List<String> frequencyList = <String>[
  'Every Day',
  'Every Week',
  'Every Other Week',
  'Every Month'
];

// TODO(clearfeld): expend this into its own class
const List<String> reminderList = <String>['Off', 'On'];

// TODO(clearfeld): change this to an enum later
const List<String> targetTypeList = <String>['At least', 'At most'];

class PageCreateNewHabitMeasurable extends ConsumerStatefulWidget {
  const PageCreateNewHabitMeasurable({
    super.key,
    required this.isarService,
    this.fHabit,
  });

  final IsarService isarService;
  final Habit? fHabit;

  @override
  ConsumerState<PageCreateNewHabitMeasurable> createState() => _PageCreateNewHabitMeasurable();
  // State<Page_CreateNewHabitMeasurable> createState() => _Page_CreateNewHabitMeasurable();
}

class _PageCreateNewHabitMeasurable extends ConsumerState<PageCreateNewHabitMeasurable> {
  final nameTextController = TextEditingController();
  final questionTextController = TextEditingController();
  final unitTextController = TextEditingController();
  final targetTextController = TextEditingController();
  String frequencyValue = frequencyList.first;
  String targetTypeValue = targetTypeList.first;
  String reminderValue = reminderList.first;
  final reminderOn = TextEditingController();
  final notesTextController = TextEditingController();
  final reminderTextController = TextEditingController();

  // create some values
  Color pickerColor = const Color(0xff443a49);
  final currentColor = TextEditingController();
  final customColor = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);

    if (widget.fHabit != null) {
      nameTextController.text = widget.fHabit?.getTitle() ?? "";
      questionTextController.text = widget.fHabit?.getQuestion() ?? "";
      unitTextController.text = widget.fHabit?.getUnit() ?? "";
      targetTextController.text = widget.fHabit?.getTarget().toString() ?? "";
      if (widget.fHabit?.getReminderTime() != null) {
        dateController.text = widget.fHabit?.getReminderTime() ?? "12:00";  //"12:00";
        reminderTextController.text = widget.fHabit?.getReminderMessage() ?? "";
        reminderOn.text = 't';
      }
      else {
        dateController.text = "12:00";
        reminderTextController.text = "";
      }
      customColor.text = '0xff443a49';
      currentColor.text = widget.fHabit?.getColorString() ?? '0xfff16567';

      if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.everyDay) {
        frequencyValue = 'Every Day';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.xTimesPerWeek) {
        frequencyValue = 'Every Week';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.xTimesPerMonth) {
        frequencyValue = 'Every Month';
      }

      // // String frequencyValue = frequencyList.first;

      // // String reminderValue = reminderList.first;
      notesTextController.text = widget.fHabit?.getNotes() ?? "";

      if (widget.fHabit?.getColorString() != '0xfff16567' &&
          widget.fHabit?.getColorString() != '0xff2ec977' &&
          widget.fHabit?.getColorString() != '0xff5666f3' &&
          widget.fHabit?.getColorString() != '0xfff7f186' &&
          widget.fHabit?.getColorString() != '0xff9186f4') {
        customColor.text = widget.fHabit?.getColorString() ?? '0xff443a49';
      }
    } else {
      dateController.text = "12:00";
      customColor.text = '0xff443a49';
      currentColor.text = '0xfff16567';
    }
  }

  @override
  void dispose() {
    nameTextController.dispose();
    unitTextController.dispose();
    targetTextController.dispose();
    questionTextController.dispose();
    notesTextController.dispose();
    super.dispose();
  }

  void addHabit() {
    var freq = EHABITFREQUENCY.everyDay;
    if (frequencyValue == 'Every Day') {
      freq = EHABITFREQUENCY.everyDay;
    } else if (frequencyValue == 'Every Week') {
      freq = EHABITFREQUENCY.xTimesPerWeek;
    } else if (frequencyValue == 'Every Month') {
      freq = EHABITFREQUENCY.xTimesPerMonth;
    }

    if (widget.fHabit != null) {
      var h = widget.fHabit;
      var c = currentColor.text;
      var reminderText;
      var reminderTime;
      if (reminderOn.text == 't') {
        reminderText = reminderTextController.text;
        reminderTime = dateController.text;
      }
      h?.title = nameTextController.text;
      h?.question = questionTextController.text;
      h?.unit = unitTextController.text;
      h?.target = int.parse(targetTextController.text);
      h?.notes = notesTextController.text;
      h?.color = c;
      h?.frequency = freq;
      h?.reminderMessage = reminderText;
      h?.reminderTime = reminderTime;

      widget.isarService.updateHabit(h);
    } else {
      var c = currentColor.text;
      var reminderText;
      var reminderTime;
      if (reminderOn.text == 't') {
        reminderText = reminderTextController.text;
        reminderTime = dateController.text;
      }

      widget.isarService.saveHabit(Habit.fullMeasurable(
          EHABITS.measurable,
          nameTextController.text,
          c,
          unitTextController.text,
          int.parse(targetTextController.text),
          freq,
          1,
          reminderTime,
          reminderText,
          questionTextController.text,
          notesTextController.text));
    }
    // TODO: add measurable habit save
    // widget.isar_service.saveHabit(
    //   Habit.Full(
    //     E_HABITS.YES_OR_NO,
    //     nameTextController.text,
    //     currentColor.toString(),
    //     questionTextController.text,
    //     notesTextController.text
    //   )
    // );

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text(
    //         nameTextController.text + " " +
    //         currentColor.toString() + " " +
    //         questionTextController.text + " " +
    //         unitTextController.text + " " +
    //         targetTextController.text + " " +
    //         frequencyValue + " " +
    //         targetTypeValue + " " +
    //         reminderValue + " " +
    //         notesTextController.text
    //       )
    //     );
    //   },
    // );
  }

  void leavePage(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: customColors.background,
      appBar: AppBar(
        title: Text(widget.fHabit?.getTitle() ?? "New Habit", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: customColors.navbarBackground,
        surfaceTintColor: Colors.transparent,
        shadowColor: null,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Row(children: [
            InkWell(
              child: Text("Save", style: TextStyle(color: customColors.textColorLink)),
              onTap: () {
                if (nameTextController.text == '') {
                  // var res =
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: customColors.background,
                          surfaceTintColor: customColors.background,
                          title: const Text('Please enter a valid title.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('Okay', style: TextStyle(color: customColors.textColorLink)),
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(customColors.backgroundCompliment)),
                              onPressed: () {
                                // setState(() => currentValue = initialValue);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                }
                else if (targetTextController.text == '') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: customColors.background,
                        surfaceTintColor: customColors.background,
                        title: const Text('Please enter a valid Target Amount.'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text('Okay', style: TextStyle(color: customColors.textColorLink)),
                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(customColors.backgroundCompliment)),
                            onPressed: () {
                              // setState(() => currentValue = initialValue);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                } else {
                  addHabit();
                  ref.read(dataUpdate.notifier).setUpdate();
                  leavePage(context);
                }
              }
            ),
            SizedBox(width: 10,)
          ],)
        ],
        leading: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Text("Cancel", style: TextStyle(color: customColors.textColorSecondary),),
                onTap: () {Navigator.of(context).pop();}
              )
            )
          ]
        )
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(
              minWidth: 320,
              maxWidth: 896, // 16 * 56
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const Text(
                //   'Create your new habit',
                // ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatTextField(
                      textController: nameTextController,
                      hintText: "Title",
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ColorSelect(currentColor: currentColor, customColor: customColor,),
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Question", style: TextStyle(fontWeight: FontWeight.bold),), 
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatTextField(
                      textController: questionTextController,
                      hintText: "e.g. How many miles did you run today?",
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Unit", style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatTextField(
                      textController: unitTextController,
                      hintText: "e.g. miles",
                    ),
                  ],
                ),

                const SizedBox(
                  height: 32.0,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 80.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Target", style: TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 8.0,
                          ),
                          FlatTextField(
                            textController: targetTextController,
                            hintText: "e.g. 15",
                            keyboardType: 'num',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Frequency", style: TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 8.0,
                          ),
                          FlatDropdown(
                            value: frequencyValue,
                            onValueChanged: (String? valueArg) {
                              setState(() {
                                frequencyValue = valueArg!;
                              });
                            },
                            items: frequencyList,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 32.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Text("Target Type", style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatDropdown(
                      value: targetTypeValue,
                      onValueChanged: (String? valueArg) {
                        setState(() {
                          targetTypeValue = valueArg!;
                        });
                      },
                      items: targetTypeList,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text("Reminder", style: TextStyle(fontWeight: FontWeight.bold),),
                        Expanded(child: SizedBox()),
                        FlatSwitch(reminderController: reminderOn,),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        FlatDatePicker(dateController: dateController,),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: FlatTextField(
                            textController: reminderTextController,
                            hintText: "Reminder Message",
                          ),
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatTextField(
                      textController: notesTextController,
                      hintText: "(Optional)",
                      textarea: true
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
