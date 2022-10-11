import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../habits.dart';
import './Habits/HabitLine.dart';
import './FiveDayLine.dart';

class HabitListMain extends ConsumerStatefulWidget {
  const HabitListMain({
      super.key,
  });

  @override
  _HabitListMain createState() => _HabitListMain();
}

class _HabitListMain extends ConsumerState<HabitListMain> {
  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);
  }

  @override
  Widget build(BuildContext context) {

    final him = ref.watch(habitsManagerProvider);

    // TODO: scrollview

    return Column(
      children: <Widget>[

        FiveDayLine(),

        Column(
          children: <Widget>[
            for(var habit in him)
            if(habit is Habit_YesOrNo) ...[
              Container(
                color: Color.fromRGBO(31, 31, 31, 1.0),
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(8.0),
                child: HabitLine(
                  habit: habit
                ),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
