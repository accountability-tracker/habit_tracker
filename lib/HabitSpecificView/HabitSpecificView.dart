import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import "../s_isar.dart";
import "../entities/habit.dart";

import '../habits.dart';

import 'package:habit_tracker/habit_enums.dart';

import '../components/FlatTextField.dart';
// import '../components/FlatDropdown.dart';

import 'package:habit_tracker/CreateNewHabitYesOrNo/CreateNewHabitYesOrNo.dart';
import 'package:habit_tracker/CreateNewHabitMeasurable/CreateNewHabitMeasurable.dart';

import 'package:habit_tracker/HabitSpecificview/HabitVariablesOverviewBlock.dart';
import 'package:habit_tracker/HabitSpecificview/HistoryChart.dart';

class Page_HabitSpecificView extends ConsumerStatefulWidget {
  const Page_HabitSpecificView({
      super.key,
      required this.isar_service,
      required this.habit
  });

  final IsarService isar_service;

  // TODO: eventually handle the other habit types besides yes or no
  final dynamic habit;

  @override
  _Page_HabitSpecificView createState() => _Page_HabitSpecificView();
}

class _Page_HabitSpecificView extends ConsumerState<Page_HabitSpecificView> {
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
            icon: Icon(Icons.edit),
            onPressed: () {
              switch (widget.habit.getType()) {
                case E_HABITS.YES_OR_NO:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page_CreateNewHabitYesOrNo(
                      isar_service: widget.isar_service,
                      f_habit: widget.habit
                  )),
                );
                break;

                case E_HABITS.MEASURABLE:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page_CreateNewHabitMeasurable(
                      isar_service: widget.isar_service,
                      f_habit: widget.habit
                  )),
                );
                break;

                default:
                  print("error - habit type isnt yes-or-no or measurable");
                break;
              }
            }
          ),

          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            color: Colors.red,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Archive",style: TextStyle(color: Colors.white),),
              ),

              PopupMenuItem<int>(
                value: 1,
                child: Text("Export",style: TextStyle(color: Colors.white),),
              ),

              PopupMenuItem<int>(
                value: 2,
                child: Text("Delete",style: TextStyle(color: Colors.white),),
              ),
            ],
            onSelected: (item) async {
              // print(item)
              if(item == 0) {
                await widget.isar_service.changeHabitArchivedState(widget.habit.id, !widget.habit.IsArchived());
              }

              if(item == 2) {
                await widget.isar_service.deleteHabit(widget.habit.id);
                Navigator.pop(context);
              }
            },
          ),

        ],

      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.9,

          child: Column(
            children: <Widget>[

              // Text(
              //   widget.habit.getTitle(),
              // ),

              HabitVariablesOverviewBlock(
                isar_service: widget.isar_service,
                habit: widget.habit,
              ),

              SizedBox(height: 16.0,),

              HistoryChart(
                isar_service: widget.isar_service,
                habit: widget.habit,
              ),

            ],
          ),
        ),

      ),
    );
  }
}
