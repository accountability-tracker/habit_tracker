import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';
import 's_isar.dart';

import 'components/Drawer_Cust.dart';
import 'CreateNewHabitYesOrNo/CreateNewHabitYesOrNo.dart';
import 'CreateNewHabitMeasurable/CreateNewHabitMeasurable.dart';
import 'components/HabitListMain.dart';
import './AboutPage/AboutPage.dart';
import './SettingsPage/SettingsPage.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final ThemeMode tm = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,

      theme: cust_lightTheme,
      darkTheme: cust_darkTheme,
      themeMode: tm,

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  // TODO: make a riverpod instance that keeps track of the Isar Instance
  final isar_service = IsarService();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        _counter++;
    });
  }

  void _more_option_selected(int item) {
    print(item);
    if(item == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Page_About()),
      );
    }
    // if i == 1 delete TODO
  }

  @override
  Widget build(BuildContext context) {

    final ThemeMode tm = ref.watch(themeProvider);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {

              showDialog(
                context: context,
                builder: (context) {
                  return Scaffold(
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Spacer(),

                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Page_CreateNewHabitYesOrNo(
                                    isar_service: isar_service
                                )),
                              );
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Yes or No",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                                  ),

                                  SizedBox(height: 8.0,),

                                  Text(
                                    "e.g. Did you wake up early today? Did you exercise? Did you play chess?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),

                              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                border: Border.all(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),

                          SizedBox(height: 4.0,),

                                                    GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Page_CreateNewHabitMeasurable(
                                    isar_service: isar_service
                                )),
                              );
                            },
                            child: Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Measurable",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                  ),
                                ),

                                SizedBox(height: 8.0,),

                                Text(
                                  "e.g. How many miles did you run today? How many pages did you read?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),

                              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              border: Border.all(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          ),

                          SizedBox(height: 4.0,),

                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"),
                          ),

                          Spacer(),
                        ],
                      ),
                    ),
                  );
                  //     Navigator.of(context).pop();
                }
              );

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Page_CreateNewHabitYesOrNo(
              //       isar_service: isar_service
              //   )),
              // );
            }
          ),

          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Page_Settings()),
              );
            }
          ),

          if(ref.watch(themeProvider) == ThemeMode.dark) ...[
            IconButton(
              icon: Icon(Icons.light_mode),
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ] else if(ref.watch(themeProvider) == ThemeMode.light) ...[
            IconButton(
              icon: Icon(Icons.dark_mode),
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ],

          PopupMenuButton(
            icon: Icon(Icons.sort),
            color: Colors.red,
            itemBuilder: (context) => [
              // Text(
              //   "Sort",
              //   style: TextStyle(color: Colors.white),
              // ),

              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.arrow_upward),
                    Text("Manually",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),

              PopupMenuItem<int>(
                value: 1,
                child: Text("By name",style: TextStyle(color: Colors.white),),
              ),

              PopupMenuItem<int>(
                value: 2,
                child: Text("By color",style: TextStyle(color: Colors.white),),
              ),

              PopupMenuItem<int>(
                value: 3,
                child: Text("By status",style: TextStyle(color: Colors.white),),
              ),
            ],
            onSelected: (item) => {
              _more_option_selected(item)
            },
          ),

          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            color: Colors.red,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("About",style: TextStyle(color: Colors.white),),
              ),
            ],
            onSelected: (item) => {
              _more_option_selected(item)
            },
          ),
          //more widgets to place here
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: HabitListMain(
          isar_service: isar_service
        ),

        //   // Invoke "debug painting" (press "p" in the console, choose the
        //   // "Toggle Debug Paint" action from the Flutter Inspector in Android
        //   // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        //   // to see the wireframe for each widget.
      ),

      drawer: DrawerCust(),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
