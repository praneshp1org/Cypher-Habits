import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7286770311640613/6163531241';
    }else {
      return "";
    }
  }

  static String get StrategyPageBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7286770311640613/7115426931';
    }else {
      return "";
    }
  }

  static String get GraphPageBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7286770311640613/3038249422';
    }else {
      return "";
    }
  }
}
