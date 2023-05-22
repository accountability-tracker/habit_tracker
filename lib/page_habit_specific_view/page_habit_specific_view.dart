import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';

import 'package:habit_tracker/theme.dart';

import 'package:habit_tracker/habits.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/page_create_new_habit_yes_or_no/page_create_new_habit_yes_or_no.dart';
import 'package:habit_tracker/page_create_new_habit_measurable/page_create_new_habit_measurable.dart';

import 'package:habit_tracker/page_habit_specific_view/habit_variables_overview_block.dart';
import 'package:habit_tracker/page_habit_specific_view/history_chart.dart';
import 'package:habit_tracker/data_notifier.dart';

import 'package:habit_tracker/page_habit_specific_view/habit_calendar.dart';
import 'package:habit_tracker/page_habit_specific_view/pie_graph.dart';

class PageHabitSpecificView extends ConsumerStatefulWidget {
  const PageHabitSpecificView({super.key, required this.isarService, required this.habit});

  final IsarService isarService;

  final dynamic habit;

  @override
  ConsumerState<PageHabitSpecificView> createState() => _PageHabitSpecificView();
}

class _PageHabitSpecificView extends ConsumerState<PageHabitSpecificView> {
  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);
  }

  void removeHabit() {
    // TODO(clearfeld): delete

    // ref.watch(habitsManagerProvider.notifier).addHabit(Habit_YesOrNo(
    //   // TODO(clearfeld): pull id from isar or whatever the persistance ends up being
    //   -1,
    //   E_HABITS.YES_OR_NO,
    //   nameTextController.text,
    //   currentColor,
    //   questionTextController.text,
    //   notesTextController.text
    // ));
  }

  void leavePage(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.habit.getTitle(),
        ),
        backgroundColor: customColors.navbarBackground,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                switch (widget.habit.getType()) {
                  case EHABITS.yesOrNo:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageCreateNewHabitYesOrNo(
                              isarService: widget.isarService, fHabit: widget.habit)),
                    );
                    break;

                  case EHABITS.measurable:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageCreateNewHabitMeasurable(
                              isarService: widget.isarService, fHabit: widget.habit)),
                    );
                    break;

                  // default:
                  //   print("error - habit type isnt yes-or-no or measurable");
                  // break;
                }
              }),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.red,
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Archive",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //   const PopupMenuItem<int>(
              //     value: 1,
              //     child: Text(
              //       "Export",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onSelected: (item) async {
              // print(item)
              if (item == 0) {
                await widget.isarService
                    .changeHabitArchivedState(widget.habit.id, !widget.habit.isArchived());
                Navigator.pop(context);
                ref.read(dataUpdate.notifier).setUpdate();
              }

              if (item == 2) {
                await widget.isarService.deleteHabit(widget.habit.id);
                Navigator.pop(context);
                ref.read(dataUpdate.notifier).setUpdate();
              }
            },
          ),
        ],
      ),
      body: Container(
        color: customColors.background,
        child: Center(
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  // onReorder: (int oldIndex, int newIndex) {},

                  child: Container(
                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 16.0,
                        MediaQuery.of(context).size.width * 0.05, 16.0),
                    // width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: <Widget>[
                        // Text(
                        //   widget.habit.getTitle(),
                        // ),

                        HabitVariablesOverviewBlock(
                          isarService: widget.isarService,
                          habit: widget.habit,
                        ),

                        const SizedBox(
                          height: 8.0,
                        ),

                        const Divider(
                            thickness: 0.25,
                            color: Colors.grey,
                        ),

                        const SizedBox(
                          height: 8.0,
                        ),

                        HistoryChart(
                          isarService: widget.isarService,
                          habit: widget.habit,
                        ),

                        const SizedBox(
                          height: 8.0,
                        ),

                        HabitCalendar(
                          isarService: widget.isarService,
                          habit: widget.habit,
                        ),

                        const SizedBox(
                          height: 24.0,
                        ),

                        // const Text(
                        //   "How This Habit Compares to Others",
                        //   style: TextStyle(
                        //     fontSize: 24.0,
                        //     color: Colors.red,
                        //   ),
                        // ),

                        // FutureBuilder<List<Habit>>(
                        //     future: widget.isarService.getAllHabits(),
                        //     builder: (context, AsyncSnapshot<List<Habit>> snapshot) {
                        //       if (snapshot.hasData) {
                        //         return PieGraph(
                        //           habitList: snapshot.data,
                        //           isarService: IsarService(),
                        //         );
                        //       }
                        //       return const Text("Loading indacator...");
                        //     })
                      ],

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
