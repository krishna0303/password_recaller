import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_management/Screens/Leave_Apply/Leave_apply.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/Screens/SpleashScreen.dart';
import 'package:school_management/Screens/enter_pin.dart';
import 'package:school_management/Screens/global.dart';
import 'package:school_management/Screens/pin.dart';
import 'package:school_management/Screens/pin_authenticate.dart';

import 'Screens/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password_Recaller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: sharedPrefences == true
          ? MyAppPinEnter()
          : MyAppPin(
              requiredNumber: pinValue,
            ),
    );
  }
}
