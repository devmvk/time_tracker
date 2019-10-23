import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in_button.dart';
import 'package:time_tracker/authentication/social_sign_in_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInView extends StatelessWidget {

  final Function(FirebaseUser user) onSignIn;
  SignInView({this.onSignIn});

  void _signInAnonymously (){
    FirebaseAuth.instance.signInAnonymously()
      .then((AuthResult _result){
        onSignIn(_result.user);
      }) 
      .catchError((e){
        print(e.toString());
      });
  }

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
              height: 48.0,
            ),
            
            SocialSignInButton(
              assetName: "images/google-logo.png",
              color: Colors.white,
              onPressed: (){},
              text: "Sign in with Google",
              textColor: Colors.black87,
            ),

            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              assetName: "images/facebook-logo.png",
              color: Color(0xFF334D92),
              onPressed: (){},
              text: "Sign in with Facebook",
              textColor: Colors.white,
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
              onPressed: _signInAnonymously,
            )
          ],
        ),
      );
  }
}