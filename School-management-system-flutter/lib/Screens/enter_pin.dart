import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:school_management/Screens/global.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Screens/pin.dart';

class MyAppPinEnter extends StatelessWidget {
  // final String requiredNumber = '123456';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Code.',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create 6 digit pin number',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    onChanged: (value) {
                      print(value);
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: Colors.purple,
                      activeColor: Colors.orange,
                      selectedColor: Colors.brown,
                    ),
                    onCompleted: (value) {
                      pinValue = value;
                      sharedPrefences = false;
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => MyAppPin(requiredNumber: value),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
