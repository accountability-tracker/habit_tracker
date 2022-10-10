import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../habits.dart';
import './Habits/HabitLine.dart';

typedef void SetValueStringCallback(String? value_arg);

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
        for(var habit in him)
        if(habit is Habit_YesOrNo) ...[
          HabitLine(
            habit: habit
          ),
        ]
      ],
    );
  }
}
