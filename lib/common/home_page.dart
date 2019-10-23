import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final VoidCallback onSignOut;

  HomePage({@required this.onSignOut});

  void _signOut() async{
    await  FirebaseAuth.instance.signOut();
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