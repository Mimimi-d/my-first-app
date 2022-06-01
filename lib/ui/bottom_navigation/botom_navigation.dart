import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_app/ui/calendar/calendar_card.dart';
import 'package:my_first_app/ui/home/home_page.dart';
import 'package:my_first_app/ui/timer/timer_page.dart';

import '../login/login_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _pageList = [HomePage(), TimerPage()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: _pageList[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home),
              label: 'Home',
              // tooltip: "This is a Book Page",
              // backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              activeIcon: Icon(Icons.timer),
              label: 'Timer',
              tooltip: "This is a Business Page",
              // backgroundColor: Colors.blue,
            ),
          ],
          // type: BottomNavigationBarType.shifting,
          // ここで色を設定していても、shiftingにしているので
          // Itemの方のbackgroundColorが勝ちます。
          enableFeedback: true,
          // IconTheme系
          // 統の値が優先されます。
          iconSize: 18,
          // 横向きレイアウトは省略します。
          // landscapeLayout: 省略
          selectedFontSize: 20,
          selectedIconTheme: const IconThemeData(
              size: 30, color: Color.fromARGB(255, 94, 94, 94)),
          selectedItemColor: const Color.fromARGB(255, 62, 62, 62),
          unselectedFontSize: 15,
          unselectedIconTheme: const IconThemeData(
              size: 25, color: Color.fromARGB(255, 179, 179, 179)),
        ),
      );
    });
  }
}
