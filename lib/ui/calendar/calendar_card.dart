import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'event.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      print(focusedDay);
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },

                    eventLoader: _getEventsfromDay,

                    //To style the Calendar
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

//     return Center(
//       child: SizedBox(
//         height: 310,
//         width: 350,
//         child: Card(
//           margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
//           elevation: 20.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
//             child: Column(
//               children: [
//                 TableCalendar(
//                   rowHeight: 45,
//                   locale: 'ja_JP',
//                   // availableGestures: AvailableGestures.none,
//                   firstDay: DateTime.utc(2020, 1, 1),
//                   lastDay: DateTime.utc(2030, 12, 31),
//                   focusedDay: getTodayDate(),
//                   eventLoader: getEventForDay,
//                   headerStyle: const HeaderStyle(
//                     headerPadding: EdgeInsets.symmetric(vertical: 8.0),
//                     formatButtonVisible: false,
//                     titleCentered: true,
//                   ),
//                   calendarBuilders: CalendarBuilders(
//                     markerBuilder: (context, date, events) {
//                       Widget _buildEventsMarker(DateTime date, List events) {
//                         var _color = Colors.white;
//                         if (events.first >= 1800) {
//                           return Positioned(
//                             // right: 0,
//                             // bottom: 0,
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 color: Colors.blue[700],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               margin: const EdgeInsets.all(3),

//                               // width: ,
//                               // height: 16.0,
//                               child: Center(
//                                 child: Text(
//                                   '${date.day}',
//                                   style: TextStyle().copyWith(
//                                     color: Colors.black,
//                                     // fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else if (events.first >= 1200) {
//                           return Positioned(
//                             // right: 0,
//                             // bottom: 0,
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 color: Colors.blue[600],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               margin: const EdgeInsets.all(3),

//                               // width: ,
//                               // height: 16.0,
//                               child: Center(
//                                 child: Text(
//                                   '${date.day}',
//                                   style: TextStyle().copyWith(
//                                     color: Colors.black,
//                                     // fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else if (events.first >= 600) {
//                           return Positioned(
//                             // right: 0,
//                             // bottom: 0,
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 color: Colors.blue[300],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               margin: const EdgeInsets.all(3),

//                               // width: ,
//                               // height: 16.0,
//                               child: Center(
//                                 child: Text(
//                                   '${date.day}',
//                                   style: TextStyle().copyWith(
//                                     color: Colors.black,
//                                     // fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else if (events.first >= 300) {
//                           return Positioned(
//                             // right: 0,
//                             // bottom: 0,
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 color: Colors.blue[200],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               margin: const EdgeInsets.all(3),

//                               // width: ,
//                               // height: 16.0,
//                               child: Center(
//                                 child: Text(
//                                   '${date.day}',
//                                   style: TextStyle().copyWith(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else {
//                           return Positioned(
//                             // right: 0,
//                             // bottom: 0,
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 color: Colors.blue[100],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               margin: const EdgeInsets.all(3),

//                               // width: ,
//                               // height: 16.0,
//                               child: Center(
//                                 child: Text(
//                                   '${date.day}',
//                                   style: TextStyle().copyWith(
//                                     color: Colors.black,
//                                     // fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                       }

//                       if (events.isNotEmpty) {
//                         return _buildEventsMarker(date, events);
//                       }
//                     },
//                   ),

//                   // ),

//                   // daysOfWeekVisible: false,

//                   calendarStyle: CalendarStyle(
//                     cellMargin: const EdgeInsets.all(3),
//                     defaultDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color.fromARGB(255, 246, 246, 246),
//                       border:
//                           Border.all(color: Color.fromARGB(255, 221, 221, 221)),
//                     ),
//                     todayDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color.fromARGB(255, 246, 246, 246),
//                       border:
//                           Border.all(color: Color.fromARGB(255, 221, 221, 221)),
//                     ),
//                     outsideDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color.fromARGB(255, 246, 246, 246),
//                       border:
//                           Border.all(color: Color.fromARGB(255, 221, 221, 221)),
//                     ),
//                     weekendDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color.fromARGB(255, 246, 246, 246),
//                       border:
//                           Border.all(color: Color.fromARGB(255, 221, 221, 221)),
//                     ),
//                   ),
//                   calendarFormat: _calendarFormat,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                   '継続5日目',
//                   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           ),
//           color: const Color.fromARGB(255, 255, 255, 255),
//         ),
//       ),
//     );
//   }
// }
