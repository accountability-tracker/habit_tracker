import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/entities/habit.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:habit_tracker/components/calendar/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:habit_tracker/components/calendar/classes/event.dart';
import 'package:habit_tracker/components/calendar/classes/event_list.dart';
import 'package:habit_tracker/components/flat_textfield.dart';
import 'package:habit_tracker/theme.dart';
import 'package:intl/intl.dart';

import 'package:habit_tracker/page_habit_specific_view/habit_calendar_event_icon.dart';

import 'package:habit_tracker/habit_enums.dart';
import 'package:habit_tracker/data_notifier.dart';

class HabitCalendar extends ConsumerStatefulWidget {
  const HabitCalendar({super.key, required this.isarService, required this.habit});

  final IsarService isarService;

  final Habit habit;

  @override
  ConsumerState<HabitCalendar> createState() => _HabitCalendarState();
}

class _HabitCalendarState extends ConsumerState<HabitCalendar> {
  var now = DateTime.now();
  final DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  String _currentMonthNum = DateFormat('y-M').format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  List<String> _months_processed = [];
  bool _modifyDate = false;
  var inputNumber;
  final textController = TextEditingController();

  EventList<Event> _markedDateMap = EventList<Event>(events: {});

  late Future<List<HabitDate>>? fhabitDates;

  final Widget _eventIcon = const HabitCalendarEventIcon();

  @override
  void initState() {
    super.initState();
    // ref.read(habitsManagerProvider);
    loadHabitDates();
  }

  void loadHabitDates() {
    setState(() => {
          fhabitDates =
              widget.isarService.getHabitsDateCurrentMonth(_currentMonthNum, widget.habit.id)
        });
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    /// Example Calendar Carousel without header and custom prev & next button
    final calendarCarouselNoHeader = CalendarCarousel<Event>(
      daysTextStyle: TextStyle(
        color: customColors.textColorSecondary,
      ),
      onDayPressed: (date, events) async {
        if (widget.habit.getType() == EHABITS.yesOrNo) {
          _modifyDate = true;

          if (!ref.watch(dataUpdate)) {
            ref.read(dataUpdate.notifier).setUpdate();
          }
        }
        setState(() => _selectedDate = DateTime(date.year, date.month, date.day));
        //events.forEach((event) => print(event.title));

        if (widget.habit.getType() == EHABITS.measurable) {
          textController.text = events.length.toString();
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Set a value!', textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: customColors.background,
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Text("test"),
                        SizedBox(
                          child:FlatTextField(textController: textController, alignment: TextAlign.center),
                          width: 60,
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Got it'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormal!),
                            foregroundColor: MaterialStateColor.resolveWith((states) => customColors.textColor!),
                            surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                            overlayColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormalHover!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                            )
                          ),
                          onPressed: () {
                            if ((textController.text == '' || int.tryParse(textController.text) == null)) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      surfaceTintColor: Colors.transparent,
                                      backgroundColor: customColors.background,
                                      title: const Text('Please enter a valid number.'),
                                      content: const SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            ElevatedButton(
                                              child: const Text('Okay'),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormal!),
                                                foregroundColor: MaterialStateColor.resolveWith((states) => customColors.textColor!),
                                                surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                                                overlayColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormalHover!),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  )
                                                )
                                              ),
                                              onPressed: () {
                                                // setState(() => currentValue = initialValue);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              if (widget.habit.getType() == EHABITS.measurable) {
                                _modifyDate = true;
                              }
                              if (!ref.watch(dataUpdate)) {
                                ref.read(dataUpdate.notifier).setUpdate();
                              }
                              Navigator.of(context).pop();
                            }
                            // setState(() => currentValue = currentValue);
                          },
                        ),
                        SizedBox(width: 16,),
                        ElevatedButton(
                          child: const Text('Cancel'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormal!),
                            foregroundColor: MaterialStateColor.resolveWith((states) => customColors.textColor!),
                            surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                            overlayColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormalHover!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                            )
                          ),
                          onPressed: () {
                            textController.text = '';
                            // setState(() => currentValue = initialValue);
                            Navigator.of(context).pop();
                          },
                        ),
                      ]
                    )
                  ],
                );
              });
        }
      },
      showOnlyCurrentMonthDate: true,
      weekendTextStyle: TextStyle(
        color: customColors.textColorSecondary,
      ),
      thisMonthDayBorderColor: Colors.transparent,
      daysHaveCircularBorder: false,
      customShapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

      markedDatesMap: _markedDateMap,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.65,
      selectedDateTime: _selectedDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomTextStyle: TextStyle(
        color: customColors.textColor,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: customColors.textColor,
        fontSize: 18,
      ),
      selectedDayButtonColor: Color(widget.habit.getColor()),
      markedDateShowIcon: false,
      dayButtonColor: customColors.backgroundCompliment!,
      markedDateMoreShowTotal: false,
      markedDateWidget: Positioned(child: Container(color: Colors.transparent, height: 4.0, width: 4.0), bottom: 4.0, left: 18.0),
      markedDayButtonColor: Color(widget.habit.getColor()).withOpacity(0.5),
      markedDayTextColor: TextStyle(color: Color(widget.habit.getColor())),
      todayButtonColor: customColors.backgroundCompliment!,
      weekdayTextStyle: TextStyle(color: customColors.textColorSecondary),
      selectedDayTextStyle: TextStyle(color: Colors.white),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          _currentMonthNum = DateFormat('y-M').format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        // print('long pressed date $date');
      },
    );

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //custom icon without header
        Container(
          color: customColors.background,
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                _currentMonth,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: customColors.textColor,
                ),
              )),
              TextButton(
                child: Text('<', style: TextStyle(fontSize: 24, color: customColors.textColorSecondary, fontWeight: FontWeight.w300)),
                onPressed: () {
                  setState(() {
                    _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month - 1);
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    _currentMonthNum = DateFormat('y-M').format(_targetDateTime);
                  });
                  loadHabitDates();
                },
              ),
              TextButton(
                child: Text('>', style: TextStyle(fontSize: 24, color: customColors.textColorSecondary, fontWeight: FontWeight.w300)),
                onPressed: () {
                  setState(() {
                    _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month + 1);
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    _currentMonthNum = DateFormat('y-M').format(_targetDateTime);
                  });
                  loadHabitDates();
                },
              )
            ],
          ),
        ),
        Container(
            color: customColors.background, // const Color.fromRGBO(31, 31, 31, 1.0),
            // margin: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
            //padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
            height: MediaQuery.of(context).size.width * 0.75,
            child: FutureBuilder<List<HabitDate>>(
                future: fhabitDates,
                builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!_months_processed.contains(_currentMonthNum)) {
                      for (var h in snapshot.data!) {
                        if (h.value > 0) {
                          var eventDate = h.getDate().split('-');
                          int year = int.parse(eventDate[0]);
                          int month = int.parse(eventDate[1]);
                          int day = int.parse(eventDate[2]);

                          for (int i = 0; i < h.value; i++) {
                            _markedDateMap.add(
                                DateTime(year, month, day),
                                Event(
                                  date: DateTime(year, month, day),
                                  title: '',
                                  icon: _eventIcon,
                                ));
                          }
                        }
                      }
                      _months_processed.add(_currentMonthNum);
                    }
                    if (_modifyDate) {
                      //Date was selected.
                      if (widget.habit.getType() == EHABITS.yesOrNo) {
                        var dateFound = false;
                        for (var h in snapshot.data!) {
                          if (DateFormat('y-M-dd').format(_selectedDate) == h.date) {
                            var i = h.id;
                            var hi = h.habitId;
                            var d = h.date;
                            var v = h.value == 0 ? 1 : 0;

                            if (v == 1) {
                              _markedDateMap.add(
                                  DateTime(
                                      _selectedDate.year, _selectedDate.month, _selectedDate.day),
                                  Event(
                                    date: DateTime(
                                        _selectedDate.year, _selectedDate.month, _selectedDate.day),
                                    title: '',
                                    icon: _eventIcon,
                                  ));
                            } else {
                              _markedDateMap.removeAll(_selectedDate);
                            }

                            widget.isarService.putHabitDate(HabitDate.fullWithId(i, hi, d, v));

                            dateFound = true;
                            break;
                          }
                        }

                        if (!dateFound) {
                          String day = _selectedDate.day.toString();
                          String month = _selectedDate.month.toString();
                          widget.isarService.putHabitDate(HabitDate.full(
                              widget.habit.id, '${_selectedDate.year}-$month-$day', 1));
                          _markedDateMap.add(
                              DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
                              Event(
                                date: DateTime(
                                    _selectedDate.year, _selectedDate.month, _selectedDate.day),
                                title: '',
                                icon: _eventIcon,
                              ));
                        }
                      } else if (widget.habit.getType() == EHABITS.measurable &&
                          textController.text != '') {
                        var dateFound = false;
                        for (var h in snapshot.data!) {
                          if (DateFormat('y-M-dd').format(_selectedDate) == h.date) {
                            var id = h.id;
                            var hi = h.habitId;
                            var d = h.date;
                            var v = int.parse(textController.text);

                            if (v == h.getValue()) {
                              dateFound = true;
                              break;
                            }

                            if (v > 0) {
                              _markedDateMap.removeAll(DateTime(
                                  _selectedDate.year, _selectedDate.month, _selectedDate.day));
                              for (int i = 0; i < v; i++) {
                                _markedDateMap.add(
                                    DateTime(
                                        _selectedDate.year, _selectedDate.month, _selectedDate.day),
                                    Event(
                                      date: DateTime(_selectedDate.year, _selectedDate.month,
                                          _selectedDate.day),
                                      title: '',
                                      icon: _eventIcon,
                                    ));
                              }
                              widget.isarService.putHabitDate(HabitDate.fullWithId(id, hi, d, v));
                            } else {
                              _markedDateMap.removeAll(_selectedDate);
                            }

                            widget.isarService.putHabitDate(HabitDate.fullWithId(id, hi, d, v));

                            dateFound = true;
                            break;
                          }
                        }
                        if (!dateFound) {
                          String day = _selectedDate.day.toString();
                          String month = _selectedDate.month.toString();

                          widget.isarService.putHabitDate(HabitDate.full(widget.habit.id,
                              '${_selectedDate.year}-$month-$day', int.parse(textController.text)));
                          for (int i = 0; i < int.parse(textController.text); i++) {
                            _markedDateMap.add(
                                DateTime(
                                    _selectedDate.year, _selectedDate.month, _selectedDate.day),
                                Event(
                                  date: DateTime(
                                      _selectedDate.year, _selectedDate.month, _selectedDate.day),
                                  title: '',
                                  icon: _eventIcon,
                                ));
                          }
                        }
                      }
                      _modifyDate = false;
                    }
                    return calendarCarouselNoHeader;
                  }
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.65,
                      child: const Text(
                        "Loading indacator...",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.red,
                        ),
                      ));
                })),
      ],
    ));
  }
}
