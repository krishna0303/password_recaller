import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MyShare extends StatefulWidget {
  @override
  _MyShareState createState() => _MyShareState();
}

class _MyShareState extends State<MyShare> {
  String text = 'http://digitalreviewadda.com/';
  String subject = 'follow us';
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
          child: RaisedButton(
            child: Text('Share'),
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share(
                text,
                subject: subject,
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
              );
            },
          ),
        ),
      ),
    );
  }

  void handleBack() {
    Navigator.pop(context);
  }
}
