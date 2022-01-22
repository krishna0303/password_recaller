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
          title: Center(child: Text('Instructions')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              '''

Important points which you have to take care:
1)Before deleting this app you have to first take backup of your credentials which you have stored in this app then only you can 
delete this app otherwise your credentials will remove.
2)After using this app when you left this app make sure you have logout from your account otherwise it will 
not automatic logout so please logout whenever you are going to left this app without forget.
3)We will solve these two problems in our next versions and there are also lots of functionality come in the next versions.

Security of this app:
1)This app not stored your entered data as note in server or anywhere these data's will store in your local device.
Your data has protected.
2)we will also add more security in this app in our next higher version of this app.




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
              style: TextStyle(fontSize: 18),
            ),
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