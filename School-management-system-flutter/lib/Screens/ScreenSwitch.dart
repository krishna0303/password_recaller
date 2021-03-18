import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSwitch extends StatefulWidget {
  @override
  _ScreenSwitchState createState() => _ScreenSwitchState();
}

class _ScreenSwitchState extends State<ScreenSwitch> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 3);

    if (firstTime != null && !firstTime) {
      // Not first time
      return new Timer(_duration, navigationPageHome);
    } else {
      // First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationPageWel);
    }
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('/MyAppPin');
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed('/MyAppPinEnter');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'assets/activity.png',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),
          Center(
              child: new Image.asset(
            'assets/activity.png',
            height: 150,
            width: 300,
          )),
        ],
      ),
    );
  }
}
