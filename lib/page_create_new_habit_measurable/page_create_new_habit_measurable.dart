import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/habits.dart';

import 'package:habit_tracker/components/flat_textfield.dart';
import 'package:habit_tracker/components/flat_dropdown.dart';

// TODO(clearfeld): move this into its own file and make it an enum instead
const List<String> frequencyList = <String>[
  'Every Day',
  'Every Week',
  'Every Other Week',
  'Every Month'
];

// TODO(clearfeld): expend this into its own class
const List<String> reminderList = <String>[
  'Off',
  'On'
];

// TODO(clearfeld): change this to an enum later
const List<String> targetTypeList = <String>[
  'At least',
  'At most'
];

class PageCreateNewHabitMeasurable extends ConsumerStatefulWidget {
  const PageCreateNewHabitMeasurable({
      super.key,
      required this.isarService,
      this.fHabit,
  });

  final IsarService isarService;
  final Habit? fHabit;

  @override
  _PageCreateNewHabitMeasurable createState() => _PageCreateNewHabitMeasurable();
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
  final notesTextController = TextEditingController();

  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);

    if(widget.fHabit != null) {
      nameTextController.text = widget.fHabit?.getTitle() ?? "" ;
      questionTextController.text = widget.fHabit?.getQuestion() ?? "" ;
      unitTextController.text = widget.fHabit?.getUnit() ?? "" ;
      targetTextController.text = widget.fHabit?.getTarget().toString() ?? "" ;
      // // String frequencyValue = frequencyList.first;

      // // String reminderValue = reminderList.first;
      notesTextController.text = widget.fHabit?.getNotes() ?? "" ;

      pickerColor = Color(widget.fHabit?.getColor() ?? 0xff443a49);
      currentColor = Color(widget.fHabit?.getColor() ?? 0xff443a49);
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


    if(widget.fHabit != null) {
      var h = widget.fHabit;
      h?.title = nameTextController.text;
      h?.question = questionTextController.text;
      h?.unit = unitTextController.text;
      h?.target = int.parse(targetTextController.text);
      h?.notes = notesTextController.text;
      h?.color = currentColor.toString();

      widget.isarService.updateHabit(h);
    } else {
      var c = currentColor.toString();

      widget.isarService.saveHabit(
        Habit.FullMeasurable(
          E_HABITS.MEASURABLE,
          nameTextController.text,
          c.substring(6, c.length - 1),
          unitTextController.text,
          int.parse(targetTextController.text),
          E_HABIT_FREQUENCY.EVERY_DAY,
          1,
          "",
          questionTextController.text,
          notesTextController.text
        )
      );
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Habit (Measurable)"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),

            constraints: const BoxConstraints (
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

                          const SizedBox(height: 8.0,),

                          FlatTextField(
                            textController: nameTextController,
                            hintText: 'e.g. Run'
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16.0,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Color"),

                        const SizedBox(height: 8.0,),

                        GestureDetector (
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
                              }
                            );
                          },

                          child:
                          Container(
                            color: const Color.fromRGBO(41, 41, 41, 1.0),
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

                const SizedBox(height: 32.0,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Question"),

                    const SizedBox(height: 8.0,),

                    FlatTextField(
                      textController: questionTextController,
                      hintText: "e.g. How many miles did you run today?",
                    ),
                  ],
                ),

                const SizedBox(height: 32.0,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Unit"),

                    const SizedBox(height: 8.0,),

                    FlatTextField(
                      textController: unitTextController,
                      hintText: "e.g. miles",
                    ),
                  ],
                ),

                const SizedBox(height: 32.0,),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Target"),

                          const SizedBox(height: 8.0,),

                          FlatTextField(
                            textController: targetTextController,
                            hintText: "e.g. 15",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16.0,),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Frequency"),

                          const SizedBox(height: 8.0,),

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

                const SizedBox(height: 32.0,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Text("Target Type"),
                      ],
                    ),

                    const SizedBox(height: 8.0,),

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

                const SizedBox(height: 32.0,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                      children: <Widget> [
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

                            if(selectedTime == null) return;

                            // print("Select time - " + selectedTime.toString());
                          }
                        ),
                      ],
                    ),

                    const SizedBox(height: 8.0,),

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

                const SizedBox(height: 32.0,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Notes"),

                    const SizedBox(height: 8.0,),

                    FlatTextField(
                      textController: notesTextController,
                      hintText: "(Optional)",
                    ),
                  ],
                ),

                const SizedBox(height: 48.0,),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child:
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        ),
                        onPressed: () {
                          addHabit();
                        },
                        child: const Text('Save'),
                      ),
                    ),

                    const SizedBox(width: 16.0,),

                    Expanded(
                      child:
                      ElevatedButton(
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

        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
