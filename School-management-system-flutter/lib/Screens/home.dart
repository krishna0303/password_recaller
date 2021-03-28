import 'package:firebase_admob/firebase_admob.dart';
import 'package:school_management/ad_manager.dart';
import 'package:share/share.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management/Screens/about.dart';
import 'package:school_management/Screens/instructions.dart';
import 'package:school_management/Screens/cardList.dart';
import 'package:school_management/Screens/share.dart';
import 'package:school_management/Screens/view.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/DashboardCards.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import 'package:school_management/Widgets/UserDetailCard.dart';
import 'package:school_management/components/cards.dart';
import 'package:school_management/components/faderoute.dart';
import 'package:school_management/data/models.dart';
import 'package:school_management/data/theme.dart';
import 'package:school_management/services/database.dart';
import 'edit.dart';

class Home extends StatefulWidget {
  String email;
  Home({Key key, this.email});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String text = 'https://digitalreviewadda.com';
  String subject = 'follow me';
  ThemeData theme = appThemeLight;
  bool isFlagOn = false;
  bool headerShouldHide = false;
  List<dynamic> notesList = [];
  TextEditingController searchController = TextEditingController();
  int totalCardCnt;

  bool isSearchEmpty = true;

  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  // TODO: Implement _onInterstitialAdEvent()
  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        Home();
        break;
      default:
      // do nothing
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCardCnt();
    super.initState();
    Firebase.initializeApp();
    SystemChrome.setEnabledSystemUIOverlays([]);
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));

    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );

    // TODO: Load a Banner Ad
    _loadBannerAd();

    _isInterstitialAdReady = false;

    // TODO: Initialize _interstitialAd
    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
  }

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  getCardCnt() async {
    int fetchedCardCnt = await NotesDatabaseService.db.getNotesCntFromDB();
    setState(() {
      print("Hola: $fetchedCardCnt");
      totalCardCnt = fetchedCardCnt;
    });
  }

  setNotesFromDB() async {
    print("Entered setNotes");
    var fetchedNotes =
        await NotesDatabaseService.db.getNotesFromDB(widget.email);
    setState(() {
      notesList = fetchedNotes;
    });
  }

  void handleSearch(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isSearchEmpty = false;
      });
    } else {
      setState(() {
        isSearchEmpty = true;
      });
    }
  }

  void cancelSearch() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      searchController.clear();
      isSearchEmpty = true;
    });
  }

  void gotoEditNote() {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => EditNotePage(
                  triggerRefetch: refetchNotesFromDB,
                  email: widget.email,
                )));
  }

  void gotoAboutPage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AboutUs(),
      ),
    );
  }

  void gotoSharePage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MyShare(),
      ),
    );
  }

  void gotoCardList() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            AllCards(title: 'Home', email: widget.email, changeTheme: setTheme),
      ),
    );
  }

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

  void refetchNotesFromDB() async {
    await setNotesFromDB();
    print("Refetched notes $totalCardCnt");
  }

  openNoteToRead(NotesModel noteData) async {
    setState(() {
      headerShouldHide = true;
    });
    await Future.delayed(Duration(milliseconds: 230), () {});
    Navigator.push(
        context,
        FadeRoute(
            page: ViewNotePage(
                triggerRefetch: refetchNotesFromDB, currentNote: noteData)));
    await Future.delayed(Duration(milliseconds: 300), () {});

    setState(() {
      headerShouldHide = false;
    });
  }

  List<Widget> buildNoteComponentsList() {
    List<Widget> noteComponentsList = [];
    notesList.sort((a, b) {
      return b.date.compareTo(a.date);
    });
    if (searchController.text.isNotEmpty) {
      notesList.forEach((note) {
        if (note.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            note.content
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
          noteComponentsList.add(NoteCardComponent(
            noteData: note,
            onTapAction: openNoteToRead,
          ));
      });
      return noteComponentsList;
    }
    if (isFlagOn) {
      notesList.forEach((note) {
        if (note.isImportant)
          noteComponentsList.add(NoteCardComponent(
            noteData: note,
            onTapAction: openNoteToRead,
          ));
      });
    } else {
      notesList.forEach((note) {
        noteComponentsList.add(NoteCardComponent(
          noteData: note,
          onTapAction: openNoteToRead,
        ));
      });
    }
    return noteComponentsList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            new GlobalKey<ScaffoldState>();
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            elevation: 0,
            child: MainDrawer(),
          ),
          appBar: CommonAppBar(
            menuenabled: true,
            // notificationenabled: true,
            ontap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            title: "Dashboard",
          ),
          body: ListView(
            children: [
              UserDetailCard(
                totalCardCnt: totalCardCnt,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Expanded(
              //     child: Container(
              //       alignment: Alignment.center,
              //       margin: EdgeInsets.all(8),
              //       padding: EdgeInsets.all(16),
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black38,
              //             offset: Offset(0, 2),
              //             blurRadius: 7,
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.max,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           Expanded(
              //             child: TextField(
              //               controller: searchController,
              //               maxLines: 1,
              //               onChanged: (value) {
              //                 handleSearch(value);
              //               },
              //               autofocus: false,
              //               keyboardType: TextInputType.text,
              //               style: TextStyle(
              //                   fontSize: 18, fontWeight: FontWeight.w500),
              //               textInputAction: TextInputAction.search,
              //               decoration: InputDecoration.collapsed(
              //                 hintText: 'Search',
              //                 hintStyle: TextStyle(
              //                     color: Colors.grey.shade300,
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.w500),
              //                 border: InputBorder.none,
              //               ),
              //             ),
              //           ),
              //           IconButton(
              //             icon: Icon(
              //                 isSearchEmpty ? Icons.search : Icons.cancel,
              //                 color: Colors.grey.shade300),
              //             onPressed: cancelSearch,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Transform(
              //   transform: Matrix4.translationValues(
              //       muchDelayedAnimation.value * width, 0, 0),
              //   child: DropdownSearch<String>(
              //     validator: (v) => v == null ? "Please Select" : null,
              //     hint: "Please Select",
              //     mode: Mode.MENU,
              //     showSelectedItem: true,

              //     items: [
              //       "Quarterly",
              //       "half yearly",
              //       "First Revision",
              //       'Second Revision',
              //       'Third Revision',
              //       'Annual Exam'
              //     ],
              //     showClearButton: false,
              //     onChanged: (value) {},
              //   ),
              // ),
              // ),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
              //   child: Container(
              //     alignment: Alignment(1.0, 0),
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 10.0, right: 20.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Transform(
              //             transform: Matrix4.translationValues(
              //                 muchDelayedAnimation.value * width, 0, 0),
              //             child: Bouncing(
              //               onPress: () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (BuildContext context) =>
              //                           Attendance(),
              //                     ));
              //               },
              //               child: DashboardCard(
              //                 name: "Attendance",
              //                 imgpath: "attendance.png",
              //               ),
              //             ),
              //           ),
              //           Transform(
              //             transform: Matrix4.translationValues(
              //                 delayedAnimation.value * width, 0, 0),
              //             child: Bouncing(
              //               onPress: () {},
              //               child: DashboardCard(
              //                 name: "Profile",
              //                 imgpath: "profile.png",
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              if (_isInterstitialAdReady) {
                                _interstitialAd.show();
                              }
                              gotoEditNote();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (BuildContext context) =>
                              //           ExamResult(),
                              //     ));
                            },
                            child: DashboardCard(
                              name: "Add Card",
                              imgpath: "exam.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            // child:Text('close'.toUpperCase()),
                            onPress: () {
                              if (_isInterstitialAdReady) {
                                _interstitialAd.show();
                              }
                              print('All cards pressed');
                              gotoCardList();
                            },
                            child: DashboardCard(
                              name: "All Cards",
                              imgpath: "library.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              if (_isInterstitialAdReady) {
                                _interstitialAd.show();
                              }
                              gotoAboutPage();
                            },
                            child: DashboardCard(
                              name: "About Us",
                              imgpath: "leave_apply.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              final RenderBox box = context.findRenderObject();
                              Share.share(
                                text,
                                subject: subject,
                                sharePositionOrigin:
                                    box.localToGlobal(Offset.zero) & box.size,
                              );
                            },
                            child: DashboardCard(
                              name: "Share",
                              imgpath: "activity.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              gotoInstructionsPage();
                            },
                            child: DashboardCard(
                              name: "Instructions",
                              imgpath: "leave_apply.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void gotoInstructionsPage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Instructions(),
      ),
    );
  }
}
