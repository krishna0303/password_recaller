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
            "The main motive of our is that During the covid time We have to manage all our activities online whether it is studying or work related. For that we end up creating accounts on various online platforms. And we do need to track the authentication details of all such platforms, Which might be a difficult activity for some fellows including us. So inorder to ease this difficulty we have made this app, in which you can track all info SECURELY in the form cards.Developers: Surendra and Krishna",
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
The main motive of our is that During the covid time We have to manage all our 
activities online whether it is studying or work related. 
For that we end up creating accounts on various online platforms. 
And we do need to track the authentication details of all such platforms,  
Which might be a difficult activity for some fellows including us.
So inorder to ease this difficulty
we have made this app, in which you can track all info SECURELY in the form cards.

Developers: Surendra and Krishna
*/
