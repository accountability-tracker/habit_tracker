import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../habits.dart';

import '../components/FlatTextField.dart';
// import '../components/FlatDropdown.dart';

class Page_HabitSpecificView extends ConsumerStatefulWidget {
  const Page_HabitSpecificView({
      super.key,
      required this.habit
  });

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
            onPressed: (){

            }
          ),

          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            color: Colors.red,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Export",style: TextStyle(color: Colors.white),),
              ),

              PopupMenuItem<int>(
                value: 1,
                child: Text("Delete",style: TextStyle(color: Colors.white),),
              ),
            ],
            onSelected: (item) => {
              print(item)
              // if i == 1 delete TODO
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

              Text(
                widget.habit.getTitle(),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
