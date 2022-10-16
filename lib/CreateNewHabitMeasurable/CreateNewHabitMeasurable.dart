import "dart:async";

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import "../s_isar.dart";
import "../entities/habit.dart";
import "../habit_enums.dart";

import '../habits.dart';

import '../components/FlatTextField.dart';
import '../components/FlatDropdown.dart';

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

class Page_CreateNewHabitMeasurable extends ConsumerStatefulWidget {
  const Page_CreateNewHabitMeasurable({
      super.key,
      required this.isar_service
  });

  final IsarService isar_service;

  @override
  _Page_CreateNewHabitMeasurable createState() => _Page_CreateNewHabitMeasurable();
  // State<Page_CreateNewHabitMeasurable> createState() => _Page_CreateNewHabitMeasurable();
}

class _Page_CreateNewHabitMeasurable extends ConsumerState<Page_CreateNewHabitMeasurable> {
  final nameTextController = TextEditingController();
  final questionTextController = TextEditingController();
  final unitTextController = TextEditingController();
  final targetTextController = TextEditingController();
  String frequencyValue = frequencyList.first;
  String targetTypeValue = targetTypeList.first;
  String reminderValue = reminderList.first;
  final notesTextController = TextEditingController();

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);
  }

  @override
  void dispose() {
    nameTextController.dispose();
    super.dispose();
  }

  void addHabit() {
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
        title: Text("Create New Habit (Measurable)"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),

          constraints: BoxConstraints (
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
                        Text("Name"),

                        SizedBox(height: 8.0,),

                        FlatTextField(
                          textController: nameTextController,
                          hintText: 'e.g. Run'
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16.0,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Color"),

                      SizedBox(height: 8.0,),

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
                          color: Color.fromRGBO(41, 41, 41, 1.0),
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

              SizedBox(height: 32.0,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Question"),

                  SizedBox(height: 8.0,),

                  FlatTextField(
                    textController: questionTextController,
                    hintText: "e.g. How many miles did you run today?",
                  ),
                ],
              ),


              SizedBox(height: 32.0,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Unit"),

                  SizedBox(height: 8.0,),

                  FlatTextField(
                    textController: unitTextController,
                    hintText: "e.g. miles",
                  ),
                ],
              ),

              SizedBox(height: 32.0,),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Target"),

                        SizedBox(height: 8.0,),

                        FlatTextField(
                          textController: targetTextController,
                          hintText: "e.g. 15",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16.0,),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Frequency"),

                        SizedBox(height: 8.0,),

                        FlatDropdown(
                          value: frequencyValue,
                          onValueChanged: (String? value_arg) {
                            setState(() {
                                frequencyValue = value_arg!;
                            });
                          },
                          items: frequencyList,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.0,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget> [
                      Text("Target Type"),
                    ],
                  ),

                  SizedBox(height: 8.0,),

                  FlatDropdown(
                    value: targetTypeValue,
                    onValueChanged: (String? value_arg) {
                      setState(() {
                          targetTypeValue = value_arg!;
                      });
                    },
                    items: targetTypeList,
                  ),

                ],
              ),

              SizedBox(height: 32.0,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    children: <Widget> [
                      Text("Reminder"),

                      TextButton(
                        child: Text("Test time picker"),
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

                          print("Select time - " + selectedTime.toString());
                        }
                      ),
                    ],
                  ),

                  SizedBox(height: 8.0,),

                  FlatDropdown(
                    value: reminderValue,
                    onValueChanged: (String? value_arg) {
                      setState(() {
                          reminderValue = value_arg!;
                      });
                    },
                    items: reminderList,
                  ),
                ],
              ),

              SizedBox(height: 32.0,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Notes"),

                  SizedBox(height: 8.0,),

                  FlatTextField(
                    textController: notesTextController,
                    hintText: "(Optional)",
                  ),
                ],
              ),

              SizedBox(height: 48.0,),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // background
                        onPrimary: Colors.white, // foreground
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      ),
                      onPressed: () {
                        addHabit();
                      },
                      child: Text('Save'),
                    ),
                  ),

                  SizedBox(width: 16.0,),

                  Expanded(
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.white, // foreground
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      ),
                      onPressed: () {
                        leavePage(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),

            ],
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
