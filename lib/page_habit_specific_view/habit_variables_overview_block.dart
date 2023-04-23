import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/entities/habit.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/theme.dart';

class HabitVariablesOverviewBlock extends ConsumerStatefulWidget {
  const HabitVariablesOverviewBlock({super.key, required this.isarService, required this.habit});

  final IsarService isarService;

  final dynamic habit;

  @override
  ConsumerState<HabitVariablesOverviewBlock> createState() => _HabitVariablesOverviewBlock();
}

class _HabitVariablesOverviewBlock extends ConsumerState<HabitVariablesOverviewBlock> {
  String generateFrequencyString(EHABITFREQUENCY arg) {
    String fa = widget.habit.frequencyAmount.toString();

    switch (arg) {
      case EHABITFREQUENCY.everyDay: {
        return "Every Day";
      } break;

      case EHABITFREQUENCY.everyXDays: {
        return "Every $fa Days";
      } break;

      case EHABITFREQUENCY.xTimesPerWeek: {
        return "$fa Times a Week";
      } break;

      case EHABITFREQUENCY.xTimesPerMonth: {
        return "$fa Times a Month";
      } break;
    }

    // This should never happen
    return "Error: report";
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Overview",
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xff242430),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_month,
                          color: customColors.textColor,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text(generateFrequencyString(widget.habit.getFrequency())),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xff242430),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.notifications_rounded,
                          color: customColors.textColor,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          (widget.habit.getReminderMessage() == null || widget.habit.getReminderMessage() == "")
                              ? "OFF"
                              : widget.habit.getReminderMessage(),
                          style: TextStyle(
                            color: (widget.habit.getReminderMessage() == null ||
                                    widget.habit.getReminderMessage() == "")
                                ? Colors.grey
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xff242430),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.question_mark,
                    color: customColors.textColor,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    (widget.habit.getQuestion() == null || widget.habit.getQuestion() == "")
                        ? "N/A"
                        : widget.habit.getQuestion(),
                    style: TextStyle(
                      color:
                          (widget.habit.getQuestion() == null || widget.habit.getQuestion() == "")
                              ? Colors.grey
                              : Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          constraints: const BoxConstraints(minHeight: 96.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xff242430),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.notes,
                        color: customColors.textColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Flexible(
                    child: Text(
                      (widget.habit.getNotes() == null || widget.habit.getNotes() == "")
                          ? "N/A"
                          : widget.habit.getNotes(),
                      style: TextStyle(
                        color: (widget.habit.getNotes() == null || widget.habit.getNotes() == "")
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
