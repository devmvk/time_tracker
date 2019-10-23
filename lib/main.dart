import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in.dart';
import 'package:time_tracker/common/landing_page.dart';

void main() => runApp(TimeTracker());

class TimeTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: LandingPage()
    );
  }
}