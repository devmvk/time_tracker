import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in.dart';
import 'package:time_tracker/home/home_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/database.dart';

class LandingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          User _user = snapshot.data;
          if(_user == null){
            return SignInView.create(context);
          }else{
            return Provider<User>.value(
              value: _user,
              child: Provider<DataBase>(
                builder: (BuildContext _) => FireBaseDataBase(uid:  _user.uid),
                child: HomePage()
              ),
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