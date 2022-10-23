import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';

import 'package:habit_tracker/habits.dart';

import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/page_create_new_habit_yes_or_no/page_create_new_habit_yes_or_no.dart';
import 'package:habit_tracker/page_create_new_habit_measurable/page_create_new_habit_measurable.dart';

import 'package:habit_tracker/page_habit_specific_view/habit_variables_overview_block.dart';
import 'package:habit_tracker/page_habit_specific_view/history_chart.dart';

class PageHabitSpecificView extends ConsumerStatefulWidget {
  const PageHabitSpecificView({
      super.key,
      required this.isarService,
      required this.habit
  });

  final IsarService isarService;

  // TODO: eventually handle the other habit types besides yes or no
  final dynamic habit;

  @override
  _PageHabitSpecificView createState() => _PageHabitSpecificView();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.habit.getTitle(),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              switch (widget.habit.getType()) {
                case E_HABITS.YES_OR_NO:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageCreateNewHabitYesOrNo(
                      isarService: widget.isarService,
                      fHabit: widget.habit
                  )),
                );
                break;

                case E_HABITS.MEASURABLE:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageCreateNewHabitMeasurable(
                      isarService: widget.isarService,
                      fHabit: widget.habit
                  )),
                );
                break;

                // default:
                //   print("error - habit type isnt yes-or-no or measurable");
                // break;
              }
            }
          ),

          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.red,
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Archive",style: TextStyle(color: Colors.white),),
              ),

              const PopupMenuItem<int>(
                value: 1,
                child: Text("Export",style: TextStyle(color: Colors.white),),
              ),

              const PopupMenuItem<int>(
                value: 2,
                child: Text("Delete",style: TextStyle(color: Colors.white),),
              ),
            ],
            onSelected: (item) async {
              // print(item)
              if(item == 0) {
                await widget.isarService.changeHabitArchivedState(widget.habit.id, !widget.habit.IsArchived());
              }

              if(item == 2) {
                await widget.isarService.deleteHabit(widget.habit.id);
                Navigator.pop(context);
              }
            },
          ),

        ],

      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.9,

          child: Column(
            children: <Widget>[

              // Text(
              //   widget.habit.getTitle(),
              // ),

              HabitVariablesOverviewBlock(
                isarService: widget.isarService,
                habit: widget.habit,
              ),

              const SizedBox(height: 16.0,),

              HistoryChart(
                isarService: widget.isarService,
                habit: widget.habit,
              ),

            ],
          ),
        ),

      ),
    );
  }
}
