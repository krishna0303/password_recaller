// import 'package:school_management/Screens/cardList.dart';
import 'package:school_management/screens/LoginPage.dart';
import 'package:school_management/screens/RequestLogin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return MyHomePage(title: "krishna");
    } else {
      return RequestLogin(toggleView: toggleView);
    }
  }
}
