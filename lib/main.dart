import 'package:design_event_management_app/screens/add_event_screen.dart';
import 'package:design_event_management_app/screens/chat_screen.dart';
import 'package:design_event_management_app/screens/event_info.dart';
import 'package:design_event_management_app/screens/event_screen.dart';
import 'package:design_event_management_app/screens/home_screen.dart';
import 'package:design_event_management_app/screens/register_screen.dart';
import 'package:design_event_management_app/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:design_event_management_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login_screen": (context) => LoginScreen(),
        "home_screen": (context) => HomeScreen(),
        "register_screen": (context) => RegisterScreen(),
        "event_screen": (context) => EventScreen(),
        "chat_screen": (context) => ChatScreen(),
        "add_event_screen": (context) => AddEventScreen(),
        "event_info": (context) => EventInfo(),
        "test_screen": (context) => YEET(),
      },
      initialRoute: "home_screen",
    );
  }
}
