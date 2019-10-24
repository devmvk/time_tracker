import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {

  final AuthBase auth;


  HomePage({@required this.auth});

  void _signOut() async{
    await auth.signOut();
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