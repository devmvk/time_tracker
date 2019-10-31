import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in.dart';
import 'package:time_tracker/common/home_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_provider.dart';

class LandingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    AuthBase auth = AuthProvider.of(context);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          User _user = snapshot.data;
          if(_user == null){
            return SignInView();
          }else{
            return HomePage();
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