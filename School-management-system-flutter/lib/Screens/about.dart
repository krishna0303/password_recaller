import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
            "As college students, we spent years tutoring and leading successful study groups. But we noticed a ton of students struggling with the same thing every semester: study prep. We decided to join our university's business launch competition and really explore the issue. After months of experiments and countless student interviews, it was clear that effective note taking and study prep were two of the greatest obstacles to success for students. We won the competition and immediately started building NimbleNotes to remove those obstacles. Our goal is to improve the learning experience of every student and help them succeed in their education.",
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
