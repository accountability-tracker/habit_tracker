import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/components/radial_progress_block.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/theme.dart';
import 'package:intl/intl.dart';

class HabitVariablesOverviewBlock extends ConsumerStatefulWidget {
  const HabitVariablesOverviewBlock({super.key, required this.isarService, required this.habit});

  final IsarService isarService;

  final dynamic habit;

  @override
  ConsumerState<HabitVariablesOverviewBlock> createState() => _HabitVariablesOverviewBlock();
}

class _HabitVariablesOverviewBlock extends ConsumerState<HabitVariablesOverviewBlock> {
  late Future<List<HabitDate>>? fhabitDatesFreq;
  late Future<List<HabitDate>>? fhabitDatesMonth;
  late Future<List<HabitDate>>? fhabitDatesYear;

  @override
  void initState() {
    super.initState();
    // ref.read(habitsManagerProvider);
    loadHabitDates();
  }

  void loadHabitDates() {
    setState(() => {
          fhabitDatesMonth =
              widget.isarService.getHabitsDateCurrentMonth(DateFormat('y-M').format(DateTime.now()), widget.habit.id)
        });
    setState(() => {
          fhabitDatesYear = widget.isarService.getHabitsDateLastSelectedPeriod(
              widget.habit.id, DateFormat('y-MM-dd').format(DateTime(DateTime.now().year)).toString())
        });
    setState(() {
      if (widget.habit.getFrequency() == EHABITFREQUENCY.everyDay) {
        fhabitDatesFreq = widget.isarService.getHabitDate(widget.habit.id, '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');
      }
      if (widget.habit.getFrequency() == EHABITFREQUENCY.everyXDays) {
        fhabitDatesFreq = widget.isarService.getHabitsDateLastSelectedPeriod(widget.habit.id,
            DateFormat('y-M-dd').format(DateTime.now().subtract(Duration(days: widget.habit.getFrequencyAmount()))));
      }
      if (widget.habit.getFrequency() == EHABITFREQUENCY.xTimesPerWeek) {
        fhabitDatesFreq = widget.isarService.getHabitsDateLastSeven(widget.habit.id);
      }
      if (widget.habit.getFrequency() == EHABITFREQUENCY.xTimesPerMonth) {
        fhabitDatesFreq = widget.isarService.getHabitsDateCurrentMonth(DateFormat('y-M').format(DateTime.now()), widget.habit.id);
      }
    });
  }

  String generateFrequencyString(EHABITFREQUENCY arg) {
    String fa = widget.habit.getFrequencyAmount().toString();
    String unit = widget.habit.getUnit() ?? 'times';
    if (widget.habit.getTarget() != null) {
      fa = widget.habit.getTarget().toString();
    }

    switch (arg) {
      case EHABITFREQUENCY.everyDay: {
        return "Every Day";
      } break;

      case EHABITFREQUENCY.everyXDays: {
        return "Every $fa Days";
      } break;

      case EHABITFREQUENCY.xTimesPerWeek: {
        return "$fa $unit a Week";
      } break;

      case EHABITFREQUENCY.xTimesPerMonth: {
        return "$fa Times a Month";
      } break;
    }

    // This should never happen
    return "Error: report";
  }

  int amountDone(String period, {bool total=false}) {
    //period: The period passed in (day, month, year)
    //fa: The habit's frequency amount (day, week, month, etc.)
    EHABITFREQUENCY fa = widget.habit.getFrequency();
    int freqAmount = widget.habit.getFrequencyAmount();
    if (widget.habit.getTarget() != null) {
      freqAmount = widget.habit.getTarget();
    }
    if (total == true) {
      if (period == fa.toString()) {
        if (fa == EHABITFREQUENCY.everyXDays) {
          return 1;
        }
        return freqAmount;
      }
      else if (fa == EHABITFREQUENCY.everyDay) {
        int lastDay = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
        if (period == 'EHABITFREQUENCY.xTimesPerMonth') {
          return (lastDay * freqAmount).toInt();
        }
        else if (period == 'year') {
          return (365 * freqAmount).toInt();
        }
      }
      else if (fa == EHABITFREQUENCY.xTimesPerWeek) {
        if (period == 'EHABITFREQUENCY.xTimesPerMonth') {
          return (4 * freqAmount).toInt();
        }
        else if (period == 'year') {
          return (52 * freqAmount).toInt();
        }
      }
      else if (fa == EHABITFREQUENCY.everyXDays) {
        int lastDay = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
        if (period == 'EHABITFREQUENCY.xTimesPerMonth') {
          return lastDay ~/ freqAmount;
        }
        else if (period == 'year') {
          return 365 ~/ freqAmount;
        }
      }
      else if (fa == EHABITFREQUENCY.xTimesPerMonth) {
        if (period == 'year') {
          return (12 * freqAmount).toInt();
        }
      }
    }
    return freqAmount;
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: customColors.backgroundCompliment,
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
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: customColors.backgroundCompliment,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          (widget.habit.getReminderTime() == null || widget.habit.getReminderTime() == "")
                          ? Icons.notifications_off
                          : Icons.notifications_active,
                          color: customColors.textColor,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          (widget.habit.getReminderTime() == null || widget.habit.getReminderTime() == "")
                              ? "OFF"
                              : widget.habit.getReminderTime(),
                          style: TextStyle(
                            color: (widget.habit.getReminderTime() == null ||
                                    widget.habit.getReminderTime() == "")
                                ? customColors.textColorSecondary
                                : customColors.textColor,
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
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: customColors.backgroundCompliment,
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
                              ? customColors.textColorSecondary
                              : customColors.textColor,
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
          constraints: const BoxConstraints(minHeight: 80.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: customColors.backgroundCompliment,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            ? customColors.textColorSecondary
                            : customColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Divider(
            thickness: 0.25,
            color: Colors.grey,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            FutureBuilder<List<HabitDate>>(
              future: fhabitDatesFreq,
              builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  int received = 0;
                  for (var h in snapshot.data!) {
                    received += h.value;
                  }
                  return SizedBox(
                    height: 235,
                    width: 110,
                    child: RadialProgressBlock(
                      name: generateFrequencyString(widget.habit.getFrequency()),
                      receivedNu: received,
                      totalNu: amountDone(widget.habit.getFrequency().toString(), total: true),//widget.habit.getFrequencyAmount(),
                      unit: widget.habit.getUnit() ?? 'times',
                      progressColor: Color(widget.habit.getColor()),
                      radius: 45.0,
                      textSize: 12.0,
                      titleSize: 16.0,
                    ),
                  );
                }
                else {
                  return SizedBox(
                    height: 235,
                    width: 110,
                    child: RadialProgressBlock(
                      name: generateFrequencyString(widget.habit.getFrequency()),
                      receivedNu: 0,
                      totalNu: amountDone(widget.habit.getFrequency().toString(), total: true),//widget.habit.getFrequencyAmount(),
                      unit: widget.habit.getUnit() ?? 'times',
                      progressColor: Color(widget.habit.getColor()),
                      radius: 45.0,
                      textSize: 12.0,
                      titleSize: 16.0,
                    ),
                  );
                }
              }
            ),
            SizedBox(width: 10,),
            FutureBuilder<List<HabitDate>>(
              future: fhabitDatesMonth,
              builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  int received = 0;
                  for (var h in snapshot.data!) {
                    received += h.value;
                  }
                  return SizedBox(
                    height: 235,
                    width: 110,
                    child: RadialProgressBlock(
                      name: 'This Month',
                      receivedNu: received,
                      totalNu: amountDone('EHABITFREQUENCY.xTimesPerMonth', total: true),//widget.habit.getFrequencyAmount(),
                      unit: widget.habit.getUnit() ?? 'times',
                      progressColor: Color(widget.habit.getColor()),
                      radius: 45.0,
                      textSize: 12.0,
                      titleSize: 16.0,
                    ),
                  );
                }
                else {
                  return SizedBox(
                    height: 235,
                    width: 110,
                    child: RadialProgressBlock(
                      name: 'This Month',
                      receivedNu: 0,
                      totalNu: amountDone('EHABITFREQUENCY.xTimesPerMonth', total: true),//widget.habit.getFrequencyAmount(),
                      unit: widget.habit.getUnit() ?? 'times',
                      progressColor: Color(widget.habit.getColor()),
                      radius: 45.0,
                      textSize: 12.0,
                      titleSize: 16.0,
                    ),
                  );
                }
              }
            ),
            SizedBox(width: 10,),
            FutureBuilder<List<HabitDate>>(
              future: fhabitDatesYear,
              builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  int received = 0;
                  for (var h in snapshot.data!) {
                    received += h.value;
                  }
                  return SizedBox(
                    height: 235,
                    width: 110,
                    child: RadialProgressBlock(
                      name: 'This Year',
                      receivedNu: received,
                      totalNu: amountDone('year', total: true),//widget.habit.getFrequencyAmount(),
                      unit: widget.habit.getUnit() ?? 'times',
                      progressColor: Color(widget.habit.getColor()),
                      radius: 45.0,
                      textSize: 12.0,
                      titleSize: 16.0,
                    ),
                  );
                }
                else {
                  return SizedBox(
                    height: 235,
                    width: 110,
                    child: RadialProgressBlock(
                      name: 'This Year',
                      receivedNu: 0,
                      totalNu: amountDone('year', total: true),//widget.habit.getFrequencyAmount(),
                      unit: widget.habit.getUnit() ?? 'times',
                      progressColor: Color(widget.habit.getColor()),
                      radius: 45.0,
                      textSize: 12.0,
                      titleSize: 16.0,
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ],
    );
  }
}
