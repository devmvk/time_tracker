import 'package:flutter/material.dart';
import 'package:time_tracker/common/landing_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_provider.dart';

void main() => runApp(TimeTracker());

class TimeTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      child: MaterialApp(
        title: "Time Tracker",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo
        ),
        home: LandingPage()
      ),
      auth: Auth(),
    );
  }
}