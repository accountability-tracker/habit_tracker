import 'package:flutter/material.dart';

import 'package:habit_tracker/theme.dart';

class HabitCalendarEventIcon extends StatelessWidget {
  const HabitCalendarEventIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: Icon(
        Icons.done,
        color: customColors.text_color,
      ),
    );
  }
}
