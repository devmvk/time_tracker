import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in.dart';
import 'package:time_tracker/common/home_page.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;

  LandingPage({@required this.auth});

  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          User _user = snapshot.data;
          if(_user == null){
            return SignInView(
              auth: auth,
            );
          }else{
            return HomePage(
              auth: auth,
            );
          }
        }else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}