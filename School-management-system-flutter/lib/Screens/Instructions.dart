import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: handleBack,
          ),
          backgroundColor: Colors.blueGrey[900],
          title: Center(child: Text('About Us')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            '''
After Opening the app
1) If new user click on request for ID button
2) that will take you to the registration page register yourself by entering your details
3) then after entering the details an email verification will happen
4) After the verification you will be automatically get logged IN.
5) If not a new user enter your login details and click on login
6) you will be able to login to the app
7) Then 4 options will be visible
    a) Add card - To add a new card in which your password along all the other details will be stored
    b) All cards - This will list all the cards you have created till now
    c) About us - This page will give some info about the developer
    d) Share - This page will enable you to share this app
    e) Instructions - This page will give the same instructions which are being given here
    Developers: Surendra and Krishna
            ''',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  void handleBack() {
    Navigator.pop(context);
  }
}




/*
After Opening the app
1) If new user click on request for ID button
2) that will take you to the registration page register yourself by entering your details
3) then after entering the details an email verification will happen
4) After the verification you will be automatically get logged IN.
5) If not a new user enter your login details and click on login
6) you will be able to login to the app
7) Then 4 options will be visible
    a) Add card - To add a new card in which your password along all the other details will be stored
    b) All cards - This will list all the cards you have created till now
    c) About us - This page will give some info about the developer
    d) Share - This page will enable you to share this app
    e) Instructions - This page will give the same instructions which are being given here
    Developers: Surendra and Krishna
*/