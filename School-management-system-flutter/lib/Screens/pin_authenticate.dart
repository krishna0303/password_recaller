import 'package:school_management/authentication/pin_code_view.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return PinCode(
      title: Text(
        "Lock Screen",
        style: TextStyle(
            color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
      ),

      subTitle: Text(
        "Enter the pin code",
        style: TextStyle(color: Colors.white),
      ),
      codeLength: 6,
      // you may skip correctPin and plugin will give you pin as
      // call back of [onCodeFail] before it clears pin
      correctPin: "123456",
      onCodeSuccess: (code) {
        // print(code);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHomePageBio(title: 'Fingerprint Authentication'),
          ),
        );
      },
      onCodeFail: (code) {
        print(code);
      },
    );
  }
}
