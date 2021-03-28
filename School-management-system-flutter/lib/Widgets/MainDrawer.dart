import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Attendance/Attendance.dart';
import 'package:school_management/Screens/Exam/Exam_Rseult.dart';
import 'package:school_management/Screens/Leave_Apply/Leave_apply.dart';
import 'package:school_management/Screens/about.dart';
import 'package:school_management/Screens/cardList.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/Screens/share.dart';
import 'package:school_management/Widgets/DrawerListTile.dart';
import 'package:school_management/data/theme.dart';
import 'package:school_management/services/auth.dart';
import 'package:share/share.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String text = 'https://digitalreviewadda.com';
  String subject = 'follow me';
  ThemeData theme = appThemeLight;
  bool isFlagOn = false;
  bool headerShouldHide = false;
  final AuthService _auth = AuthService();
  List<dynamic> notesList = [];
  TextEditingController searchController = TextEditingController();
  int totalCardCnt;

  bool isSearchEmpty = true;
  final auth = FirebaseAuth.instance;
  @override
  setTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      setState(() {
        theme = appThemeDark;
      });
    } else {
      setState(() {
        theme = appThemeLight;
      });
    }
  }

  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerListTile(
            imgpath: "home.png",
            name: "Home",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
            }),
        // DrawerListTile(
        //   imgpath: "attendance.png",
        //   name: "Attendance",
        //   ontap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (BuildContext context) => Attendance(),
        //       ),
        //     );
        //   },
        // ),
        // DrawerListTile(
        //     imgpath: "classroom.png", name: "Class work", ontap: () {}),
        DrawerListTile(
            imgpath: "profile.png",
            name: "Profile",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
            }),
        DrawerListTile(
          imgpath: "library.png",
          name: "All Cards",
          ontap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    AllCards(title: 'Home', changeTheme: setTheme),
              ),
            );
          },
        ),
        // DrawerListTile(imgpath: "fee.png", name: "Fees", ontap: () {}),
        // DrawerListTile(
        //     imgpath: "calendar.png", name: "Time Table", ontap: () {}),
        // DrawerListTile(imgpath: "library.png", name: "Library", ontap: () {}),
        // DrawerListTile(imgpath: "downloads.png", name: "Downloads"),
        // DrawerListTile(imgpath: "bus.png", name: "Track ", ontap: () {}),
        DrawerListTile(
          imgpath: "leave_apply.png",
          name: "About Us",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AboutUs(),
              ),
            );
          },
        ),
        DrawerListTile(
            imgpath: "activity.png",
            name: "Share",
            ontap: () {
              final RenderBox box = context.findRenderObject();
              Share.share(
                text,
                subject: subject,
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
              );
            }),

        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('logout'),
          onPressed: () {
            auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
        //   DrawerListTile(
        //       imgpath: "notification.png", name: "Notification", ontap: () {}),
      ],
    );
  }
}
