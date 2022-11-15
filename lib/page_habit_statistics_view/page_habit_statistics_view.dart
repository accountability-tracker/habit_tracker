import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';

import 'package:habit_tracker/habits.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/page_create_new_habit_yes_or_no/page_create_new_habit_yes_or_no.dart';
import 'package:habit_tracker/page_create_new_habit_measurable/page_create_new_habit_measurable.dart';

import 'package:habit_tracker/page_habit_specific_view/history_chart.dart';
import 'package:habit_tracker/page_habit_statistics_view/habit_calendar.dart';
import 'package:habit_tracker/page_habit_statistics_view/pie_graph.dart';

class PageHabitStatisticsView extends ConsumerStatefulWidget {
  const PageHabitStatisticsView({
      super.key,
      required this.isarService,
      required this.habit
  });

  final IsarService isarService;

  // TODO: eventually handle the other habit types besides yes or no
  final dynamic habit;

  @override
  _PageHabitStatisticsView createState() => _PageHabitStatisticsView();
}

class _PageHabitStatisticsView extends ConsumerState<PageHabitStatisticsView> {
  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider); 
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
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.9,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Text(
                  widget.habit.getTitle(),
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 16.0,),

                HistoryChart(
                  isarService: widget.isarService,
                  habit: widget.habit,
                ),

                const SizedBox(height: 16.0,),

                HabitCalendar(
                  isarService: widget.isarService,
                  habit: widget.habit,
                ),

                const SizedBox(height: 16.0,),
                
                const Text(
                  "How This Habit Compares to Others",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.red,
                  ),
                ),

                FutureBuilder<List<Habit>>(
                  future: widget.isarService.getAllHabits(),
                  builder: (context, AsyncSnapshot<List<Habit>> snapshot) {
                    if(snapshot.hasData) {
                      return PieGraph(
                        habitList: snapshot.data,
                        isarService: IsarService(),
                      );
                    }
                    return const Text(
                      "Loading indacator..."
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}