import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../components/FlatTextField.dart';
import '../components/FlatDropdown.dart';

const List<String> frequencyList = <String>[
  'Every Day',
  'Every Week',
  'Every Other Week',
  'Every Month'
];

const List<String> reminderList = <String>[
  'Off',
  'On'
];

class Page_CreateNewHabitYesOrNo extends StatefulWidget {
  const Page_CreateNewHabitYesOrNo({super.key});

  @override
  State<Page_CreateNewHabitYesOrNo> createState() => _Page_CreateNewHabitYesOrNo();
}

class _Page_CreateNewHabitYesOrNo extends State<Page_CreateNewHabitYesOrNo> {
  // int _counter = 0;

  final nameTextController = TextEditingController();
  final questionTextController = TextEditingController();
  String frequencyValue = frequencyList.first;

  String reminderValue = reminderList.first;
  final notesTextController = TextEditingController();

  // void _incrementCounter() {
  //   setState(() {
  //       _counter++;
  //   });
  // }


  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }


  @override
  void dispose() {
    nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Habit (Yes or No)"),
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
                          hintText: 'e.g. Exercise'
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
                    hintText: "e.g. Did you exercise today?",
                  ),
                ],
              ),

              SizedBox(height: 32.0,),

              Column(
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

              SizedBox(height: 32.0,),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Reminder"),

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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                nameTextController.text + " " +
                                questionTextController.text + " " +
                                frequencyValue + " " +
                                reminderValue + " " +
                                notesTextController.text + " " +
                                currentColor.toString()
                              ),
                            );
                          },
                        );
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
                        Navigator.pop(context);
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
