import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_first_app/ui/bottom_navigation/botom_navigation.dart';
import 'package:my_first_app/ui/calendar/calendar_card.dart';
import 'package:my_first_app/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_first_app/ui/login/login_page.dart';
import 'package:my_first_app/ui/register/register_page.dart';
import 'package:my_first_app/ui/timer/timer_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() {
//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.currentPlatform,
//   // );
//   WidgetsFlutterBinding.ensureInitialized();
//   initializeDateFormatting().then((_) => runApp(MyApp()));
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(
//     // Riverpodでデータを受け渡しできる状態にする
//     ProviderScope(
//       child: LoginPage(),
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // Riverpodでデータを受け渡しできる状態にする
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter table calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
