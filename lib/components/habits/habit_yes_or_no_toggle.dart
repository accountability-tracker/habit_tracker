import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/entities/habit_date.dart';
import 'package:habit_tracker/theme.dart';

class HabitYesOrNoToggle extends StatefulWidget {
  HabitYesOrNoToggle(
      {Key? key,
      required this.habit,
      required this.date,
      required this.isarService})
      : super(key: key);

  // TODO(clearfeld): update this to work with other habit types
  final Habit habit;
  final DateTime date;
  final IsarService isarService;

  @override
  State<HabitYesOrNoToggle> createState() => _HabitYesOrNoToggle();
}

class _HabitYesOrNoToggle extends State<HabitYesOrNoToggle> {
  bool toggledOn = false; // reserved for null habit dates.
  late Future<List<HabitDate>>? fhabitDate;

  @override
  void initState() {
    super.initState();
    loadHabitDate();
  }

  void loadHabitDate() {
    setState(() {
      fhabitDate = widget.isarService.getHabitDate(widget.habit.id, '${widget.date.year}-${widget.date.month}-${widget.date.day}');
    });
  }

  @override
  Widget build(BuildContext context) {
    var customColors = Theme.of(context).extension<CustomColors>()!;
    // TODO(clearfeld): fix this to update on clcik\

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: FutureBuilder<List<HabitDate>>(
            future: fhabitDate,
            builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data!.isEmpty) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          toggledOn = toggledOn ? false : true;
                        });
                        var id = widget.isarService.putHabitDate(HabitDate.full(widget.habit.id,
                        '${widget.date.year}-${widget.date.month}-${widget.date.day}', toggledOn ? 1 : 0));
                      },
                      icon: (toggledOn ? const Icon(Icons.check, weight: 1, size: 40,) : const Icon(Icons.close, size: 40,)),
                      color: (toggledOn ? Color(widget.habit.getColor()) : customColors.iconDisabled),  //Color(widget.habit.getColor())
                    );
                  }
                  else {
                    var habitDate = snapshot.data![0];
                    return IconButton(
                      onPressed: () {
                        var x = habitDate.getValue();
                        setState(() {
                          x = x == 0 ? 1 : 0;
                          habitDate.setValue(x);
                        });
                        widget.isarService.toggleHabitDate(habitDate);
                      },
                      icon: (habitDate.getValue() != 0 ? const Icon(Icons.check, weight: 1, size: 40,) : const Icon(Icons.close, size: 40,)),
                      color: (habitDate.getValue() != 0 ? Color(widget.habit.getColor()) : customColors.iconDisabled),  //Color(widget.habit.getColor())
                    );
                  }
                default:
                  return IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close, size: 40,),
                    color: customColors.iconDisabled
                  );
              }
            },
          ),
        )
      ],
    );
  }
}
