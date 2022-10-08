import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Name"),

                      FlatTextField(
                        textController: nameTextController,
                        hintText: 'e.g. Exercise'
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Color"),

                      // TextField(
                      //   controller: nameTextController,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(),
                      //     hintText: "e.g. Exercise",
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),

            Text("Question"),
            FlatTextField(
              textController: questionTextController,
              hintText: "e.g. Did you exercise today?",
            ),

            Text("Frequency"),
            FlatDropdown(
              value: frequencyValue,
              onValueChanged: (String? value_arg) {
                setState(() {
                    frequencyValue = value_arg!;
                });
              },
              items: frequencyList,
            ),

            Text("Reminder"),
            FlatDropdown(
              value: reminderValue,
              onValueChanged: (String? value_arg) {
                setState(() {
                    reminderValue = value_arg!;
                });
              },
              items: reminderList,
            ),

            Text("Notes"),
            FlatTextField(
              textController: notesTextController,
              hintText: "(Optional)",
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
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
                            notesTextController.text
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Save'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () { },
                  child: Text('Cancel'),
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
    );
  }
}
