import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in.dart';
import 'package:time_tracker/common/home_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    AuthBase auth = Provider.of<AuthBase>(context);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          User _user = snapshot.data;
          if(_user == null){
            return SignInView.create(context);
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