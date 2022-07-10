import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils.dart';
import 'event.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'new_record.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Duration duration = const Duration(hours: 0, minutes: 0);
  // late Map<int, int> selectedEvents;
  Map<DateTime, List<int>> _eventsList = {};

  @override
  void initState() {
    //Map<DateTime, List<int>>型
    _eventsList = {
      DateTime.now().add(Duration(days: -1)): [121],
      DateTime.now().add(Duration(days: -2)): [61],
      DateTime.now().add(Duration(days: -3)): [1],
      DateTime.now().add(Duration(days: -4)): [30],
      DateTime.now().add(Duration(days: -5)): [60],
      DateTime.now().add(Duration(days: -6)): [90],
    };
    super.initState();
  }

  void _addNewTransaction(int txAmount, DateTime chosenDate) {
    var sam;
    setState(() {
      if (_eventsList.containsKey(chosenDate)) {
        _eventsList[chosenDate]?.add(txAmount);
        sam = _eventsList[chosenDate]
            ?.reduce((value, element) => value + element);
        _eventsList[chosenDate] = [sam];
      } else {
        _eventsList.addAll({
          chosenDate: [txAmount]
        });
      }
      print(_eventsList);
    });
  }

  void _startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewRecord(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  void dispose() {
    // _eventController.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  int getHashCode(DateTime key) {
    // print(key.day * 1000000 + key.month * 10000 + key.year);
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      // ハッシュコードはobjectを識別するint型
      // getHashCodeは、hashCodeが Function(DateTime)と定義されている為、()の引数はいらない
      // hashCode:(datetime){return getHashCode(datetime);}は、hashCode: getHashCodeと同定義 ,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List _getEventForDay(DateTime day) {
      //  _events[day]がnullでなければ、 _events[day]を返す。
      // print("_events" + '$_events');
      return _events[day] ?? [];
    }

    return Scaffold(
      body: SizedBox(
        height: 320,
        child: Card(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TableCalendar(
                  focusedDay: selectedDay,
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),

                  calendarFormat: format,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,
                  //Day Changed
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focusDay;
                    });
                    // print(focusedDay);
                  },
                  // selectedDayPredicate: (DateTime date) {
                  //   return isSameDay(selectedDay, date);
                  // },
                  calendarBuilders: CalendarBuilders(
                    todayBuilder: (context, day, _) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          // shape: BoxShape.rectangle,
                          color: Colors.blueGrey[300],
                          shape: BoxShape.circle,
                          // border: Border.all(),
                          // borderRadius: BorderRadius.circular(5),
                        ),
                        width: 38.0,
                        height: 38.0,
                        child: Center(
                          child: Text(
                            '${DateTime.now().day}',
                            style: TextStyle().copyWith(
                              // color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      );
                    },
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return _buildEventsMarker(date, events);
                      }
                    },
                    defaultBuilder: (context, day, _) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 38.0,
                        height: 38.0,
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle().copyWith(
                              // color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  eventLoader: _getEventForDay,
                  //To style the Calendar
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    // todayDecoration: BoxDecoration(
                    //   border: Border.all(),
                    //   color: Colors.purpleAccent,
                    //   shape: BoxShape.rectangle,
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewRecord(context),
      ),
    );
  }
}

Widget _buildEventsMarker(DateTime date, List events) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: date.day == DateTime.now().day
        ? BoxDecoration(
            shape: BoxShape.circle,
            color: _colorChange(events),
            // color: Colors.blue[300],
            // borderRadius: BorderRadius.circular(5),
          )
        : BoxDecoration(
            shape: BoxShape.rectangle,
            color: _colorChange(events),
            // color: Colors.blue[300],
            borderRadius: BorderRadius.circular(5),
          ),
    width: 38.0,
    height: 38.0,
    child: Center(
      child: Text(
        '${date.day}',
        style: TextStyle().copyWith(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    ),
  );
}

_colorChange(List events) {
  int num = 0;
  if (events.first >= 120) {
    num = 800;
  } else if (events.first >= 90) {
    num = 600;
  } else if (events.first >= 60) {
    num = 500;
  } else if (events.first >= 30) {
    num = 300;
  } else {
    num = 100;
  }

  return Colors.blue[num];
}
