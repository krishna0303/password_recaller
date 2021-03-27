import 'package:flutter/material.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/Screens/enter_pin.dart';
import 'package:school_management/Screens/global.dart';
import 'package:school_management/Screens/SpleashScreen.dart';
import 'package:school_management/services/database.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var user;
  @override
  void initState() {
    NotesDatabaseService.db.getUserDetailFromDB().then((user) {
      setState(() {
        print(user.name);
        this.user = user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password_Recaller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpleashScreen(),
      // home: user != null
      //     ? MyAppPin(
      //         requiredNumber: user.pin,
      //       )
      //     : MyAppPinEnter(),
    );
  }
}
