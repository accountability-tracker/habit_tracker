import 'package:flutter/material.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit_date.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';
class HabitCalendar extends StatefulWidget {
  const HabitCalendar({
      super.key,
      required this.isarService,
      required this.habit
  });

  final IsarService isarService;

  // TODO: eventually handle the other habit types besides yes or no
  final dynamic habit;

  @override
  _HabitCalendarState createState() => new _HabitCalendarState();
}

class _HabitCalendarState extends State<HabitCalendar> {
  var now = DateTime.now();
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  String _currentMonthNum = DateFormat('y-M').format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  final Widget _eventIcon = Container(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.only(
      bottom: 5.0,
    ),
    child: const Icon(
      Icons.done,
      color: Colors.white,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(events: {});

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      daysTextStyle: const TextStyle(
        color: Colors.white,
      ),
      onDayPressed: (date, events) {
        //setState(() => _selectedDate = date);
        events.forEach((event) => print(event.title));
      },
      showOnlyCurrentMonthDate: true,
      weekendTextStyle: const TextStyle(
        color: Colors.white,
      ),
      thisMonthDayBorderColor: Colors.transparent,
      markedDatesMap: _markedDateMap,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.65,
      //selectedDateTime: _selectedDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.red,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.red,
      ),
      selectedDayButtonColor: Color(widget.habit.getColor()),

      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreCustomTextStyle: TextStyle(
                              fontSize: 8,
                              color: Colors.white),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      markedDateMoreShowTotal: true,
      markedDateIconMargin: 9,
      markedDateIconOffset: 3,

      todayButtonColor: const Color.fromRGBO(41, 41, 41, 1.0),
      selectedDayTextStyle: const TextStyle(color: Colors.red),
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
        print('long pressed date $date');
      },
    );

    return Container(
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon without header
              Container(
                color: Color.fromRGBO(31, 31, 31, 1.0),
                margin: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _currentMonth,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      )),
                    TextButton(
                      child: const Text('PREV'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                          _currentMonthNum = DateFormat('y-M').format(_targetDateTime);
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                          _currentMonthNum = DateFormat('y-M').format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                color: const Color.fromRGBO(31, 31, 31, 1.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),

                child: FutureBuilder<List<HabitDate>>(
                  future: widget.isarService.getHabitsDateCurrentMonth( _currentMonthNum, widget.habit.id),
                  builder: (context, AsyncSnapshot<List<HabitDate>> snapshot) {

                    if(snapshot.connectionState == ConnectionState.done) {
                      if (_markedDateMap.events.isEmpty) {
                        for(var h in snapshot.data!) {
                          if(h.value > 0) {
                            var eventDate = h.getDate().split('-');
                            int year = int.parse(eventDate[0]);
                            int month = int.parse(eventDate[1]);
                            int day = int.parse(eventDate[2]);

                            for(int i=0; i<h.value; i++) {
                              _markedDateMap.add(
                                DateTime(year, month, day),
                                Event(
                                  date: DateTime(year, month, day),
                                  title: '',
                                  icon: _eventIcon,
                                )
                              );
                            }
                          }
                        }
                      }
                      return _calendarCarouselNoHeader;
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.65,
                      child:
                        const Text(
                          "Loading indacator...",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.red,
                          ),
                        )
                    );
                  }
                )
              ),
            ],
          ),
        ));
  }
}