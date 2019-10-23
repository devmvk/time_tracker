import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in.dart';
import 'package:time_tracker/common/home_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseUser _user;

  void _updateAuthentication(FirebaseUser user){
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return SignInView(
        onSignIn: _updateAuthentication,
      );
    }else{
      return HomePage();
    }
  }
}