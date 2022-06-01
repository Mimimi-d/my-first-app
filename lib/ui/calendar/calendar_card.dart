import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  DateTime getTodayDate() {
    initializeDateFormatting('ja');
    DateTime Today = DateTime.now();

    return Today;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 310,
        width: 350,
        child: Card(
          margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: Column(
              children: [
                TableCalendar(
                  rowHeight: 45,
                  locale: 'ja_JP',
                  // availableGestures: AvailableGestures.none,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: getTodayDate(),
                  headerStyle: const HeaderStyle(
                    headerPadding: EdgeInsets.symmetric(vertical: 8.0),
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),

                  // daysOfWeekVisible: false,

                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.all(3),
                    defaultDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 89, 177, 249),
                    ),
                    todayDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 89, 177, 249),
                    ),
                    outsideDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 89, 177, 249),
                    ),
                    weekendDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 89, 177, 249),
                    ),
                  ),
                  calendarFormat: _calendarFormat,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  '継続7日目',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
