import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  'Per Day',
  'Per Week',
  'Bi-weekly',
  'Per Month',
  'Every # Days'
];

// TODO(clearfeld): expend this into its own class
const List<String> reminderList = <String>['Off', 'On'];

class PageCreateNewHabitYesOrNo extends ConsumerStatefulWidget {
  const PageCreateNewHabitYesOrNo({
    super.key,
    required this.isarService,
    this.fHabit,
  });

  final IsarService isarService;
  final Habit? fHabit;

  @override
  ConsumerState<PageCreateNewHabitYesOrNo> createState() => _PageCreateNewHabitYesOrNo();
  // State<Page_CreateNewHabitYesOrNo> createState() => _Page_CreateNewHabitYesOrNo();
}

class _PageCreateNewHabitYesOrNo extends ConsumerState<PageCreateNewHabitYesOrNo> {
  final nameTextController = TextEditingController();
  final questionTextController = TextEditingController();
  String frequencyValue = frequencyList.first;

  String reminderValue = reminderList.first;
  final notesTextController = TextEditingController();

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  final frequencyAmountController = TextEditingController();

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);

    if (widget.fHabit != null) {
      nameTextController.text = widget.fHabit?.getTitle() ?? "";
      questionTextController.text = widget.fHabit?.getQuestion() ?? "";
      frequencyAmountController.text = widget.fHabit?.getFrequencyAmount().toString() ?? "1";

      if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.everyDay) {
        frequencyValue = 'Per Day';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.xTimesPerWeek) {
        frequencyValue = 'Per Week';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.xTimesPerMonth) {
        frequencyValue = 'Per Month';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.everyXDays) {
        frequencyValue = 'Every # Days';
      }
      // // String frequencyValue = frequencyList.first;

      // // String reminderValue = reminderList.first;
      notesTextController.text = widget.fHabit?.getNotes() ?? "";

      pickerColor = Color(widget.fHabit?.getColor() ?? 0xff443a49);
      currentColor = Color(widget.fHabit?.getColor() ?? 0xff443a49);
    } else {
      frequencyAmountController.text = "1";
    }
  }

  @override
  void dispose() {
    nameTextController.dispose();
    questionTextController.dispose();
    notesTextController.dispose();
    frequencyAmountController.dispose();
    super.dispose();
  }

  void addHabit() {
    var freq = EHABITFREQUENCY.everyDay;
    if (frequencyValue == 'Per Day') {
      freq = EHABITFREQUENCY.everyDay;
    } else if (frequencyValue == 'Per Week') {
      freq = EHABITFREQUENCY.xTimesPerWeek;
    } else if (frequencyValue == 'Per Month') {
      freq = EHABITFREQUENCY.xTimesPerMonth;
    } else if (frequencyValue == 'Every # Days') {
      freq = EHABITFREQUENCY.everyXDays;
    }

    if (widget.fHabit != null) {
      var h = widget.fHabit;
      var c = currentColor.toString();
      h?.title = nameTextController.text;
      h?.question = questionTextController.text;
      h?.notes = notesTextController.text;
      h?.color = c.substring(6, c.length - 1);
      h?.frequency = freq;
      h?.frequencyAmount = int.parse(frequencyAmountController.text);

      widget.isarService.updateHabit(h);
    } else {
      var c = currentColor.toString();

      widget.isarService.saveHabit(Habit.full(
          EHABITS.yesOrNo,
          nameTextController.text,
          c.substring(6, c.length - 1),
          freq,
          int.parse(frequencyAmountController.text),
          "",
          questionTextController.text,
          notesTextController.text));
    }

    ref.watch(habitsManagerProvider.notifier).addHabit(HabitYesOrNo(
        // TODO(clearfeld): pull id from isar or whatever the persistance ends up being
        -1,
        EHABITS.yesOrNo,
        nameTextController.text,
        currentColor,
        questionTextController.text,
        notesTextController.text));

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text(
    //         nameTextController.text + " " +
    //         questionTextController.text + " " +
    //         frequencyValue + " " +
    //         reminderValue + " " +
    //         notesTextController.text + " " +
    //         currentColor.toString()
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
      appBar: AppBar(
        title: const Text("Create New Habit (Yes or No)"),
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

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Name"),
                          const SizedBox(
                            height: 8.0,
                          ),
                          FlatTextField(
                              textController: nameTextController, hintText: 'e.g. Exercise'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Color"),

                        const SizedBox(
                          height: 8.0,
                        ),

                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: pickerColor,
                                        onColorChanged: changeColor,
                                      ),
                                      // Use Material color picker:
                                      //
                                      // child: MaterialPicker(
                                      //   pickerColor: pickerColor,
                                      //   onColorChanged: changeColor,
                                      //   showLabel: true, // only on portrait mode
                                      // ),
                                      //
                                      // Use Block color picker:
                                      //
                                      // child: BlockPicker(
                                      //   pickerColor: currentColor,
                                      //   onColorChanged: changeColor,
                                      // ),
                                      //
                                      // child: MultipleChoiceBlockPicker(
                                      //   pickerColors: currentColors,
                                      //   onColorsChanged: changeColors,
                                      // ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(() => currentColor = pickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            color: customColors.background, //const Color.fromRGBO(41, 41, 41, 1.0),
                            width: 48.0,
                            height: 48.0,

                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              color: currentColor,
                              width: 48.0,
                              height: 48.0,
                            ),
                          ),
                        ),

                        // TextField(
                        //   controller: nameTextController,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     hintText: "e.g. Exercise",
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 32.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Question"),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatTextField(
                      textController: questionTextController,
                      hintText: "e.g. Did you exercise today?",
                    ),
                  ],
                ),

                const SizedBox(
                  height: 32.0,
                ),

                Row(
                  children: const [
                    Text("Frequency"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25.0,
                          ),
                          FlatTextField(
                            textController: frequencyAmountController,
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
                          const Text(""),
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
                      children: <Widget>[
                        const Text("Reminder"),
                        TextButton(
                            child: const Text("Test time picker"),
                            onPressed: () async {
                              TimeOfDay? selectedTime = await showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,

                                // 24 Hour format - setting
                                // builder: (BuildContext context, Widget? child) {
                                //   return MediaQuery(
                                //     data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                //     child: child!,
                                //   );
                                // },
                              );

                              if (selectedTime == null) return;

                              // print("Select time - " + selectedTime.toString());
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatDropdown(
                      value: reminderValue,
                      onValueChanged: (String? valueArg) {
                        setState(() {
                          reminderValue = valueArg!;
                        });
                      },
                      items: reminderList,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 32.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Notes"),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatTextField(
                      textController: notesTextController,
                      hintText: "(Optional)",
                    ),
                  ],
                ),

                const SizedBox(
                  height: 48.0,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        ),
                        onPressed: () {
                          if (nameTextController.text == '') {
                            // var res =
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Please enter a valid title.'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Okay'),
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
                        },
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        ),
                        onPressed: () {
                          leavePage(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
