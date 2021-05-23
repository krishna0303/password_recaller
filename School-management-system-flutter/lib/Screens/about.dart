import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import '../ad_manager.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
        handleBack();
        break;
      default:
      // do nothing
    }
  }

  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    // TODO: implement dispose

    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

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
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  void handleBack() {
    if (_isInterstitialAdReady) {
      _interstitialAd.show();
    }
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
