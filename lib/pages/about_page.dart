import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('ABOUT'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            Text(
              'Driving force',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Over the past few decades, a lot of motivational speakers, and life coaches have trumpeted the magic number 21, which has an awesome catch to it: it is too short not to be inspirational. Imagine having to break any habit no matter how difficult it is in just three weeks, who would not want that? This is the reason why it has become so popular.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Forming a new habit is not an event, but a process. This is the danger that 21-day cycle fails to address, because once the 21-day period is over, and the new habit has not been formed, one could get discouraged and lose hope. But it does not have to be so when one realizes that this is a journey, and even though you may not tell exactly how long it will take you to get there, as long as you remain on the path, you will arrive at your destination.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Getting Inspired',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'The ancient Chinese philosopher, Lao Tzu, once said, “The journey of a thousand miles begins with a single step.” So whether it is going to take you 21 days or 211 days, you still have to start. What is more important than trying to form a new habit, is the attitude towards it. This app will help you in your journey of cultivating new habits. You can graphically track your habits progression with the app. The more committed you are towards your habits, the darker the habits map becomes. So even if you want to go with a certain number of days, that is okay. However, don’t treat it like an event, but like a process. Eventually, you will achieve your desired outcome.',
              textAlign: TextAlign.justify,
              style: TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
