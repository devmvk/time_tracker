import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Time Tracker"),
          centerTitle: true,
        ),  
        body: _buildScreen(),
      ),
    );
  }

  Container _buildScreen() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RaisedButton(
              onPressed: (){},
              child: Text("Sign in with Google"),
            )
          ],
        ),
      );
  }
}