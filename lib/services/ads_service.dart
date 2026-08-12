
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  BannerAd? banner;

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  BannerAd createBanner({required void Function() onLoaded}) {
    banner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // TEST ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) => onLoaded()),
    )..load();
    return banner!;
  }

  void dispose() => banner?.dispose();
}
