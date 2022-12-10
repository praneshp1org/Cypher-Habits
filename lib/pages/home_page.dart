import 'dart:developer';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habittrackertute/components/habit_tile.dart';
import 'package:habittrackertute/components/month_summary.dart';
import 'package:habittrackertute/components/my_fab.dart';
import 'package:habittrackertute/components/my_alert_box.dart';
import 'package:habittrackertute/data/habit_database.dart';
import 'package:habittrackertute/pages/about_app.dart';
// import 'package:habittrackertute/pages/onlyheat_map.dart';
import 'package:habittrackertute/pages/strategy_guide.dart';
import 'package:habittrackertute/pages/helper/ad_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  BannerAd? _bannerAd;
  bool _isAdLoaded = false; // flag yo halena bhane ad naauney raixa
   Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }



  @override
  
  void initState() {
    // if there is no current habit list, then it is the 1st time ever opening the app
    // then create default data

    //banner ad initialization
    BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          _bannerAd = ad as BannerAd;
          _isAdLoaded=true;
        });
      },
      onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        ad.dispose();
      },
    ),
  ).load();
 

    
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // there already exists data, this is not the first time
    else {
      db.loadData();
    }

    // update the database
    db.updateDatabase();

    
    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    // show alert dialog for user to enter the new habit details
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter habit name..',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });

    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel new habit
  void cancelDialogBox() {
    // clear textfield
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (_bannerAd!=null)?Container(width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!)):Container(
                height: 0,
                ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Container(child: new DrawerHeader(child: new CircleAvatar(
              child: Image.asset('assets/logo.png'),
            )),color: Colors.white,),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container (
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                color: Colors.grey[300],
                child: new Column(
                  children: [
                     Padding(
                      
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=>StrategyGuidePage());
                    
                    
                  },
                  child: ListTile(
                    
                    title: Text("Strategy guide", style: TextStyle(color: Colors.black),),
                    subtitle: Text('"..on building new habits"', style: TextStyle(fontStyle: FontStyle.italic),),
                    leading: Icon(Icons.electric_bolt, color: Colors.green, size: 30,),
                  ),
                ),
              ),
              
                  ],
                ),
              ),
            ), 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container (
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                color: Colors.grey[300],
                child: new Column(
                  children: [
                     Padding(
                      
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=>AboutAppPage());
                    
                  },
                  child: ListTile(
                    
                    title: Text("About app", style: TextStyle(color: Colors.black),),
                    subtitle: Text('"..how does it work?"', style: TextStyle(fontStyle: FontStyle.italic),),
                    leading: Icon(Icons.info, color: Colors.green, size: 30,),
                  ),
                ),
              ),
              
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container (
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                color: Colors.grey[300],
                child: new Column(
                  children: [
                     Padding(
                      
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    
                    
                  },
                  child: ListTile(
                    
                    title: Text("Rate App", style: TextStyle(color: Colors.black),),
                    subtitle: Text('Your reviews and feedbacks are always welcomed!', style: TextStyle(fontStyle: FontStyle.italic),),
                    leading: Icon(Icons.rate_review, color: Colors.green, size: 30,),
                  ),
                ),
              ),
              
              
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container (
            //     // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //     color: Colors.grey[300],
            //     child: new Column(
            //       children: [
            //          Padding(
                      
            //     padding: const EdgeInsets.symmetric(horizontal: 5),
            //     child: GestureDetector(
            //       onTap: () {
            //         Get.to(OnlyHeatMap());
                    
            //       },
            //       child: ListTile(
                    
            //         title: Text("Only Graph", style: TextStyle(color: Colors.black),),
            //         subtitle: Text('This will show graoh only.', style: TextStyle(fontStyle: FontStyle.italic),),
            //         leading: Icon(Icons.graphic_eq, color: Colors.green, size: 30,),
            //       ),
            //     ),
            //   ),
              
              
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CYPHER '),
            Icon(Icons.hardware),
            Text(
              ' HABITS',
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
            
          // monthly summary heat map
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),

          // list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          )
        ],
      ),
      
      
    );
  }
}
