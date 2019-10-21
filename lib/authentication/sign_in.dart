import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in_button.dart';

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
            SignInButton(
              color: Colors.white,
              textColor: Colors.black87,
              text: "Sign in with Google",
              onPressed: (){},
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              color: Color(0xFF334D92),
              textColor: Colors.white,
              text: "Sign in with Facebook",
              onPressed: (){},
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              color: Colors.teal.shade700,
              textColor: Colors.white,
              text: "Sign in with Google",
              onPressed: (){},
            ),
            SizedBox(
              height: 8.0,
            ),
            Text("or", textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0, color: Colors.black87),),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              color: Colors.lime.shade300,
              textColor: Colors.black87,
              text: "Go anonymous",
              onPressed: (){},
            )
          ],
        ),
      );
  }
}