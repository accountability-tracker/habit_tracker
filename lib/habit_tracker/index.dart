import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/entities/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:habit_tracker/components/drawer_cust.dart';
import 'package:habit_tracker/habit_tracker/add_habit_type_modal.dart';

import 'package:habit_tracker/theme.dart';
import 'package:habit_tracker/data_notifier.dart';
import 'package:habit_tracker/s_isar.dart';

// import 'package:habit_tracker/components/drawer_cust.dart';
import 'package:habit_tracker/components/habit_list_main.dart';
import 'package:habit_tracker/page_about/page_about.dart';
// import 'package:habit_tracker/page_settings/page_settings.dart';

class HabitTrackerHome extends ConsumerStatefulWidget {
  const HabitTrackerHome({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HabitTrackerHome> createState() => _HabitTrackerHomeState();
}

class _HabitTrackerHomeState extends ConsumerState<HabitTrackerHome> {
  // TODO: make a riverpod instance that keeps track of the Isar Instance
  final isarService = IsarService();
  var habitView = 'input';

// TODO: meta app info checks should probably live in their own file and be in a root level comp ahead of the router
// fine for now but when folder and file cleanup is under way this should also be moved
 PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    VerifyMetaInformation();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  void VerifyMetaInformation() async {
    final appMetaInfo = await isarService.getAppMetaInfo();
    print("App Meta Info");
    print(appMetaInfo);

    if(appMetaInfo == null) {
        final appMetaInfov = AppMetaInfo.full(
            _packageInfo.version
        );

        await isarService.saveAppMetaInfo(appMetaInfov);
    } else {
        // TODO: check version if different from current app version do upgrade path if needed
    }
  }

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
          surfaceTintColor: Colors.transparent,
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
                        return AddHabitTypeModal(
                            isarService: isarService, refreshHabitList: refreshHabitList);
                      });
                }),

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
              color: customColors.backgroundCompliment,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "About",
                    style: TextStyle(color: customColors.textColor),
                  ),
                ),
              ],
              onSelected: (item) => {_moreOptionSelected(item)},
            ),
            //more widgets to place here
          ],
        ),
        body: Center(
          child: HabitListMain(
            isarService: isarService,
            habitView: habitView,
            updateFunction: refreshHabitList,
          ),

          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
        ),

        // drawer: const DrawerCust(),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
