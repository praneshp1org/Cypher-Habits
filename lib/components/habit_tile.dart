import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        
        endActionPane: ActionPane(
          
          motion: const StretchMotion(),
          children: [
            // settings option
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),

            // delete option
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(habitName),
            // subtitle: (habitCompleted)?Icon(Icons.check):Icon(Icons.ads_click_sharp),
            leading: Checkbox(
                activeColor: Colors.green,
                value: habitCompleted,
                onChanged: onChanged,
              ),
              trailing: (habitCompleted)?Icon(Icons.arrow_back_ios_new, color: Colors.black,):Icon(Icons.clear, color: Colors.red,)
          ),
          // child: Row(
          //   children: [
          //     // checkbox
          //     Checkbox(
          //       activeColor: Colors.green,
          //       value: habitCompleted,
          //       onChanged: onChanged,
          //     ),

          //     // habit name
          //     Text(habitName),

              
          //   ],
          // ),
        ),
      ),
    );
  }
}
