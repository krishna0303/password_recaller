import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8485232027472811~5821644411";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8485232027472811/8507517504";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8485232027472811/9830555073";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-3940256099942544/8673189370";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/7552160883";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }
}
