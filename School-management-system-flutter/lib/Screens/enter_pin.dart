import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:school_management/Screens/global.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Screens/pin.dart';
import 'package:school_management/data/models.dart';
import 'package:school_management/services/database.dart';

class MyAppPinEnter extends StatefulWidget {
  // final String requiredNumber = '123456';
  @override
  _MyAppPinEnterState createState() => _MyAppPinEnterState();
}

class _MyAppPinEnterState extends State<MyAppPinEnter> {
  String name;

  String pin;

  UserModel currentUser;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    currentUser = UserModel(pin: '', name: '');

    super.initState();
  }

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
                TextFormField(
                  validator: (value) {
                    RegExp nameRegExp = RegExp('[a-zA-Z]');
                    RegExp numberRegExp = RegExp(r'\d');
                    if (value.isEmpty) {
                      return 'You Must enter your Name!';
                    } else if (nameRegExp.hasMatch(value)) {
                      return null;
                    } else {
                      return 'Enter Vaild name';
                    }
                  },
                  onChanged: (val) {
                    print(val);
                    name = val;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Create 6 digit pin number',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                PinCodeTextField(
                    appContext: context,
                    length: 6,
                    // obscureText: true,
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
                      pin = value;
                      print("Hola before");
                      handleRegistration();

                      // sharedPrefences = false;
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

  void handleRegistration() async {
    print("Hola ki maa ki");
    setState(() {
      currentUser.name = name;
      currentUser.pin = pin;
      print('Hey there ${currentUser.name}');
    });
    var latestUser =
        await NotesDatabaseService.db.addUserDetailInDB(currentUser);
    print("After corection");
    print(latestUser.name);
    print(latestUser.pin);
  }
}

