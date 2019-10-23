import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {

  final VoidCallback onSignOut;
  final AuthBase auth;


  HomePage({@required this.auth ,@required this.onSignOut});

  void _signOut() async{
    await auth.signOut();
    onSignOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            FlatButton(
              onPressed: _signOut,
              child: Text("Logout", style: TextStyle(color: Colors.white,),
            ))
          ],
        ),
      ),
    );
  }
}