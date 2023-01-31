import 'package:flutter/material.dart';
import 'package:habittrackertute/data/habit_database.dart';
import 'package:habittrackertute/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IndividialDaySummary extends StatefulWidget {
  IndividialDaySummary({super.key, required this.dateTime}); 
  final DateTime dateTime;

  @override
  State<IndividialDaySummary> createState() => _IndividialDaySummaryState();
}

class _IndividialDaySummaryState extends State<IndividialDaySummary> {
 HabitDatabase db = HabitDatabase();

  final _myBox = Hive.box("Habit_Database");

   List clickedHabitList = [['Habits', true]];
  //  List streakList = ['Habits', 0];

   

  @override
  Widget build(BuildContext context) {
        setState(() {
      loadData();
    });
    return Scaffold(
      
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text('Recap of '+widget.dateTime.year.toString()+"/"+widget.dateTime.month.toString()+"/"+widget.dateTime.day.toString()),
      ),
      body: (clickedHabitList.length==0)?Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('EMPTY!'),
          SizedBox(height: 8,),
          Text('YOU WERE UNCOMMITTED ON THIS DAY!'),
        ],
      ),):ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: clickedHabitList.length,
        itemBuilder: (context, index){
          return (clickedHabitList.isEmpty)?Center(
            child: Text('NO COMMIT!'),
          ): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(),
              elevation: 4,
              child: ListTile(
                title: Text(clickedHabitList[index][0]),
                // trailing: Text(clickedHabitList[index][2]),
                // trailing: (clickedHabitList[index][1]==tr),
                subtitle: (clickedHabitList[index][1])?Text('COMMITTED!'):Text('UNCOMMITTED!'),
                leading: (clickedHabitList[index][1]==true)?Container(height: 16,width: 16, color: Color.fromARGB(255, 2, 179, 8),):Container(height: 16,width: 16, color: Color.fromARGB(40, 2, 179, 8),),
              ),
            ),
          );

      }),
    );
    
  }

    void loadData() {
    // if it's a new day, get habit list from database
    if (_myBox.get(clickedDateFormatted()) == null) {
      clickedHabitList = _myBox.get(clickedDateFormatted())??[] as List;
      // streakList = _myBox.get(clickedDateFormatted())??[] as List;
      // set all habit completed to false since it's a new day
      for (int i = 0; i < clickedHabitList.length; i++) {
        clickedHabitList[i][1] = false;
        if(clickedHabitList[i][1]==true)
        {
          clickedHabitList[i][2]++;
          
        }
        // streakList[i][1]=stre;
        
      }
    }
    // if it's not a new day, load todays list
    else {
      clickedHabitList = _myBox.get(clickedDateFormatted())??[] as List;
      // streakList = _myBox.get(clickedDateFormatted())??[] as List;
      if(clickedHabitList.isEmpty)
      {
        print('Nothing');
      }else{
            for (int i = 0; i < clickedHabitList.length; i++) {
        print(clickedHabitList[i][0]);
        // print(clickedHabitList[i][2]);
        // print(streakList[i][0]);
      }
      }
    }

  }

  //  void loadHeatMap() {
  //   DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

  //   // count the number of days to load
  //   int daysInBetween = DateTime.now().difference(startDate).inDays;

  //   // go from start date to today and add each percentage to the dataset
  //   // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
  //   for (int i = 0; i < daysInBetween + 1; i++) {
  //     String yyyymmdd = convertDateTimeToString(
        
  //       startDate.add(Duration(days: i)),
  //     );
  //     double strengthAsPercent = double.parse(
  //       _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
  //     );
  //     // split the datetime up like below so it doesn't worry about hours/mins/secs etc.
  //     // year
  //     int year = startDate.add(Duration(days: i)).year;

  //     // month
  //     int month = startDate.add(Duration(days: i)).month;

  //     // day
  //     int day = startDate.add(Duration(days: i)).day;

  //     final percentForEachDay = <DateTime, int>{
  //       DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
  //     };
  //     print(percentForEachDay.toString());

  //     // heatMapDataSet.addEntries(percentForEachDay.entries);
  //     // print(heatMapDataSet);
  //   }
  // }

  //   // update database
  // void updateDatabase() {
  //   // update todays entry
  //   _myBox.put(todaysDateFormatted(), clickedHabitList);

  //   // update universal habit list in case it changed (new habit, edit habit, delete habit)
  //   _myBox.put("CURRENT_HABIT_LIST", clickedHabitList);

  //   // calculate habit complete percentages for each day
  //   calculateHabitPercentages();
  //   // load heat map
  //   loadHeatMap();
  // }

  //  void calculateHabitPercentages() {
  //   int countCompleted = 0;
  //   for (int i = 0; i < clickedHabitList.length; i++) {
  //     if (clickedHabitList[i][1] == true) {
  //       countCompleted++;
  //     }
  //   }

  //   String percent = clickedHabitList.isEmpty
  //       ? '0.0'
  //       : (countCompleted / clickedHabitList.length).toStringAsFixed(1);

  //   // key: "PERCENTAGE_SUMMARY_yyyymmdd"
  //   // value: string of 1dp number between 0.0-1.0 inclusive
  //   _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  //   // print(_myBox.get("PERCENTAGE_SUMMARY_${clickedDateFormatted()}", defaultValue: percent));
  //   print(_myBox.get(clickedDateFormatted()));

  // }

  String clickedDateFormatted() {
  // today
  var dateTimeObject = widget.dateTime;

  // year in the format yyyy
  String year = dateTimeObject.year.toString();

  // month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
}