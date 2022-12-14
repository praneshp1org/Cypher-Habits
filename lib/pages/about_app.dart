import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habittrackertute/pages/helper/ad_helper.dart';

class AboutAppPage extends StatefulWidget {
  AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
BannerAd? _bannerAd;

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    BannerAd(
    adUnitId: AdHelper.AboutPageBannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          _bannerAd = ad as BannerAd;
        });
      },
      onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        ad.dispose();
      },
    ),
  ).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (_bannerAd!=null)?Container(width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!)):Container(
                height: 0,
                ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('ABOUT APP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            SizedBox(height: 8,),
            Text('What does this app do?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), 
            SizedBox(height: 6,),
            Image.asset('assets/hab.jpg'),
            SizedBox(height: 6,),
            Text('This app helps you track the progression of your habits graphically. This is done with the heatmap. Basically, the more committed you are towards your habit, the better and darker is the heatmap. If you want to stick with a habit for good, one simple and effective thing you can do is keep a habit tracker. Just check the boxes of the things that you do on regular basis and the result is saved locally and heatmap is yielded. You can slide left to edit or delete the habit. This app helps you measure, quantify, and track the progress graphically. Each little measurement provides feedback. It offers a signal of whether you are making progress or need to change course. This app offers you to visualize your habit streak. It creates a visual cue that can remind you to act. It is motivating to see the progress you are making. You do not want to break your streak. It feels satisfying to record your success in the moment.', style: TextStyle(), textAlign: TextAlign.justify,), 
            Image.asset('assets/heatmap.jpg'), 
            SizedBox(height: 6,),
            
          ],
        ),
      ),
    );
  }
}