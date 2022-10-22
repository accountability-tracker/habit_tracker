import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';

import 'package:habit_tracker/habits.dart';

import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/CreateNewHabitYesOrNo/CreateNewHabitYesOrNo.dart';
import 'package:habit_tracker/CreateNewHabitMeasurable/CreateNewHabitMeasurable.dart';

import 'package:habit_tracker/HabitSpecificview/HabitVariablesOverviewBlock.dart';
import 'package:habit_tracker/HabitSpecificview/HistoryChart.dart';

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
                  MaterialPageRoute(builder: (context) => Page_CreateNewHabitYesOrNo(
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
                isar_service: widget.isarService,
                habit: widget.habit,
              ),

              const SizedBox(height: 16.0,),

              HistoryChart(
                isar_service: widget.isarService,
                habit: widget.habit,
              ),

            ],
          ),
        ),

      ),
    );
  }
}
