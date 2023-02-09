import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:habit_tracker/components/drawer_cust.dart';

import 'package:habit_tracker/theme.dart';
import 'package:habit_tracker/data_notifier.dart';
import 'package:habit_tracker/s_isar.dart';

// import 'package:habit_tracker/components/drawer_cust.dart';
import 'package:habit_tracker/page_create_new_habit_yes_or_no/page_create_new_habit_yes_or_no.dart';
import 'package:habit_tracker/page_create_new_habit_measurable/page_create_new_habit_measurable.dart';
import 'package:habit_tracker/components/habit_list_main.dart';
import 'package:habit_tracker/page_about/page_about.dart';
// import 'package:habit_tracker/page_settings/page_settings.dart';

class CalorieTrackerHome extends ConsumerStatefulWidget {
  const CalorieTrackerHome({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  ConsumerState<CalorieTrackerHome> createState() => _CalorieTrackerHomeState();
}

class _CalorieTrackerHomeState extends ConsumerState<CalorieTrackerHome> {
  // TODO: make a riverpod instance that keeps track of the Isar Instance
  final isarService = IsarService();
  var habitView = 'input';

  void _moreOptionSelected(int item) {
    // print(item);
    if (item == 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder:
              (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
            return const PageAbout();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
    // if i == 1 delete TODO
  }

  FutureOr refreshHabitList(dynamic value) {
    if (ref.watch(dataUpdate)) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: customColors.background,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: customColors.navbarBackground,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Scaffold(
                          body: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();

                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return PageCreateNewHabitYesOrNo(
                                              isarService: isarService);
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration: Duration.zero,
                                      ),
                                    ).then(refreshHabitList);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      border: Border.all(
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      children: const <Widget>[
                                        Text(
                                          "Yes or No",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          "e.g. Did you wake up early today? Did you exercise? Did you play chess?",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();

                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return PageCreateNewHabitMeasurable(
                                              isarService: isarService);
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration: Duration.zero,
                                      ),
                                    ).then(refreshHabitList);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      border: Border.all(
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      children: const <Widget>[
                                        Text(
                                          "Measurable",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          "e.g. How many miles did you run today? How many pages did you read?",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Close"),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                        //     Navigator.of(context).pop();
                      });

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Page_CreateNewHabitYesOrNo(
                  //       isar_service: isar_service
                  //   )),
                  // );
                }),

            // IconButton(
            //   icon: const Icon(Icons.settings),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const PageSettings()),
            //     );
            //   }
            // ),

            if (ref.watch(themeProvider) == ThemeMode.dark) ...[
              IconButton(
                icon: const Icon(
                  Icons.light_mode,
                  color: Colors.white,
                ),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ] else if (ref.watch(themeProvider) == ThemeMode.light) ...[
              IconButton(
                icon: const Icon(
                  Icons.dark_mode,
                  color: Colors.white,
                ),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ],

            IconButton(
              icon: Icon(
                habitView == 'input' ? Icons.bar_chart : Icons.rule,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  habitView == 'input' ? habitView = 'stats' : habitView = 'input';
                });
              },
            ),

            // PopupMenuButton(
            //   icon: const Icon(Icons.sort),
            //   color: Colors.red,
            //   itemBuilder: (context) => [
            //     // Text(
            //     //   "Sort",
            //     //   style: TextStyle(color: Colors.white),
            //     // ),

            //     PopupMenuItem<int>(
            //       value: 0,
            //       child: Row(
            //         children: const <Widget>[
            //           Icon(Icons.arrow_upward),
            //           Text("Manually",style: TextStyle(color: Colors.white),),
            //         ],
            //       ),
            //     ),

            //     const PopupMenuItem<int>(
            //       value: 1,
            //       child: Text("By name",style: TextStyle(color: Colors.white),),
            //     ),

            //     const PopupMenuItem<int>(
            //       value: 2,
            //       child: Text("By color",style: TextStyle(color: Colors.white),),
            //     ),

            //     const PopupMenuItem<int>(
            //       value: 3,
            //       child: Text("By status",style: TextStyle(color: Colors.white),),
            //     ),
            //   ],
            //   onSelected: (item) => {
            //     _moreOptionSelected(item)
            //   },
            // ),

            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              color: Colors.red,
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "About",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              onSelected: (item) => {_moreOptionSelected(item)},
            ),
            //more widgets to place here
          ],
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: HabitListMain(
            isarService: isarService,
            habitView: habitView,
            updateFunction: refreshHabitList,
          ),

          //   // Invoke "debug painting" (press "p" in the console, choose the
          //   // "Toggle Debug Paint" action from the Flutter Inspector in Android
          //   // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          //   // to see the wireframe for each widget.
        ),

        drawer: const DrawerCust(),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
