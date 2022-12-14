import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7286770311640613/4826731984';
    }else {
      return "";
    }
  }

  static String get StrategyPageBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7286770311640613/6444185547';
    }else {
      return "";
    }
  }

  static String get AboutPageBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7286770311640613/3818022205';
    }else {
      return "";
    }
  }
}
