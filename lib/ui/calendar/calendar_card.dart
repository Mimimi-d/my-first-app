import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime? _selectedDay;
  Map<DateTime, List> _eventsList = {};

  DateTime getTodayDate() {
    initializeDateFormatting('ja');
    DateTime Today = DateTime.now();

    return Today;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = getTodayDate();

    //サンプルのイベントリスト
    _eventsList = {
      DateTime(2022, 6, 1): [199],
      DateTime(2022, 6, 2): [3000],
      DateTime(2022, 6, 3): [1000],
      DateTime(2022, 6, 4): [60],
      DateTime(2022, 6, 5): [3360],

      // DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      // DateTime.now().add(Duration(days: 1)): [
      //   'Event A8',
      //   'Event B8',
      //   'Event C8',
      //   'Event D8'
      // ],
      // DateTime.now().add(Duration(days: 3)):
      //     Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      // DateTime.now().add(Duration(days: 7)): [
      //   'Event A10',
      //   'Event B10',
      //   'Event C10'
      // ],
      // DateTime.now().add(Duration(days: 11)): ['Event A11', 'Event B11'],
      // DateTime.now().add(Duration(days: 17)): [
      //   'Event A12',
      //   'Event B12',
      //   'Event C12',
      //   'Event D12'
      // ],
      // DateTime.now().add(Duration(days: 22)): ['Event A13', 'Event B13'],
      // DateTime.now().add(Duration(days: 26)): [
      //   'Event A14',
      //   'Event B14',
      //   'Event C14'
      // ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

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
                  eventLoader: getEventForDay,
                  headerStyle: const HeaderStyle(
                    headerPadding: EdgeInsets.symmetric(vertical: 8.0),
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      Widget _buildEventsMarker(DateTime date, List events) {
                        var _color = Colors.white;
                        if (events.first >= 1800) {
                          return Positioned(
                            // right: 0,
                            // bottom: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue[700],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(3),

                              // width: ,
                              // height: 16.0,
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle().copyWith(
                                    color: Colors.black,
                                    // fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (events.first >= 1200) {
                          return Positioned(
                            // right: 0,
                            // bottom: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(3),

                              // width: ,
                              // height: 16.0,
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle().copyWith(
                                    color: Colors.black,
                                    // fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (events.first >= 600) {
                          return Positioned(
                            // right: 0,
                            // bottom: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(3),

                              // width: ,
                              // height: 16.0,
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle().copyWith(
                                    color: Colors.black,
                                    // fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (events.first >= 300) {
                          return Positioned(
                            // right: 0,
                            // bottom: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(3),

                              // width: ,
                              // height: 16.0,
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle().copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Positioned(
                            // right: 0,
                            // bottom: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(3),

                              // width: ,
                              // height: 16.0,
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle().copyWith(
                                    color: Colors.black,
                                    // fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }

                      if (events.isNotEmpty) {
                        return _buildEventsMarker(date, events);
                      }
                    },
                  ),

                  // ),

                  // daysOfWeekVisible: false,

                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.all(3),
                    defaultDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Color.fromARGB(255, 246, 246, 246),
                      border:
                          Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                    ),
                    // todayDecoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10),
                    //   // color: Color.fromARGB(255, 246, 246, 246),
                    //   border:
                    //       Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                    // ),
                    outsideDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Color.fromARGB(255, 246, 246, 246),
                      border:
                          Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                    ),
                    weekendDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Color.fromARGB(255, 246, 246, 246),
                      border:
                          Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                    ),
                  ),
                  calendarFormat: _calendarFormat,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  '継続5日目',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // color: const Color.fromARGB(255, 255, 255, 255),
        ),
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
