import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habittrackertute/pages/helper/ad_helper.dart';

class StrategyGuidePage extends StatefulWidget {
  const StrategyGuidePage({super.key});

  @override
  State<StrategyGuidePage> createState() => _StrategyGuidePageState();
}

class _StrategyGuidePageState extends State<StrategyGuidePage> {
  BannerAd? _bannerAd;
   Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
      BannerAd(
    adUnitId: AdHelper.StrategyPageBannerAdUnitId,
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
        title: Text('STRATEGY GUIDE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            SizedBox(height: 20,),
            Text(
              'How to Build a New Habit: This is Your Strategy Guide',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'According to researchers at Duke University, habits account for about 40 percent of our behaviors on any given day. Understanding how to build new habits (and how your current ones work) is essential for making progress in your health, your happiness, and your life in general. But there can be a lot of information out there and most of it is not very simple to digest. To solve this problem and break things down in a very simple manner, I have created this strategy guide and developed this app for how to build new habits that actually stick.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            
            SizedBox(
              height: 8,
            ),
            Text(
              '1. Start with an incredibly small habit.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
          
             
            Image.asset('assets/startsmall.jpg'), 
            SizedBox(height: 6,),
            Text(
              'When most people struggle to build new habits, they say something like, “I just need more motivation.” Or, “I wish I had as much willpower as you do.” This is the wrong approach. Research shows that willpower is like a muscle. It gets fatigued as you use it throughout the day. Another way to think of this is that your motivation ebbs and flows. It rises and falls. Stanford professor BJ Fogg calls this the “motivation wave.” Solve this problem by picking a new habit that is easy enough that you don not need motivation to do it. Rather than starting with 50 pushups per day, start with 5 pushups per day. Rather than trying to meditate for 10 minutes per day, start by meditating for one minute per day. Make it easy enough that you can get it done without motivation.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '2. Increase your habit in very small ways.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
          
            Image.asset('assets/tiny-gains.jpg'), 
            SizedBox(height: 6,),
            Text(
              'One percent improvements add up surprisingly fast. So do one percent declines. Rather than trying to do something amazing from the beginning, start small and gradually improve. Along the way, your willpower and motivation will increase, which will make it easier to stick to your habit for good.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '3. As you build up, break habits into chunks.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
          
            Image.asset('assets/chunks.png'), 
            SizedBox(height: 6,),
            Text(
              'If you continue adding one percent each day, then you will find yourself increasing very quickly within two or three months. It is important to keep each habit reasonable, so that you can maintain momentum and make the behavior as easy as possible to accomplish. Building up to 20 minutes of meditation? Split it into two segments of 10 minutes at first. Trying to do 50 pushups per day? Five sets of 10 might be much easier as you make your way there.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '4. When you slip, get back on track quickly.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
          
            Image.asset('assets/ticks.png'), 
            SizedBox(height: 6,),
            Text(
              'Top performers make mistakes, commit errors, and get off track just like everyone else. The difference is that they get back on track as quickly as possible.You just need to be consistent, not perfect. Focus on building the identity of someone who never misses a habit twice. This app will help your track your habits progression graphically.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '5. Be patient. Stick to a pace you can sustain.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
          
            Image.asset('assets/sustain1.jpg'), 
            SizedBox(height: 6,),
            Text(
              'Learning to be patient is perhaps the most critical skill of all. You can make incredible progress if you are consistent and patient. New habits should feel easy, especially in the beginning. If you stay consistent and continue increasing your habit it will get hard enough, fast enough. It always does. This simple app will help you to self-reflect yourself on how committed are you to your habits.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
          ],
        ),
        
      ),
    );
  }
}
