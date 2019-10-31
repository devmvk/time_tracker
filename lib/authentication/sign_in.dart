import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/authentication/email_sign_in_page.dart';
import 'package:time_tracker/authentication/sign_in_button.dart';
import 'package:time_tracker/authentication/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';

class SignInView extends StatelessWidget {

  AuthBase auth;

  void _signInAnonymously () async{
    try{
      await auth.signIn();
    }catch (e){
      print(e.toString());
    }
  }

  void _googleSignIn () async{
     try{
      await auth.googleSignIn();
    }catch (e){
      print(e.toString());
    }

  }

  void _facebookSignIn () async{
    try{
      await auth.facebookSignIn();
    }catch (e){
      print(e.toString());
    }
  }

  void _emailSignIn(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => EmailSignIn()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthBase>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Time Tracker"),
          centerTitle: true,
        ),  
        body: _buildScreen(context),
      ),
    );
  }

  Container _buildScreen(BuildContext context) {
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
              onPressed: _googleSignIn,
              text: "Sign in with Google",
              textColor: Colors.black87,
            ),

            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              assetName: "images/facebook-logo.png",
              color: Color(0xFF334D92),
              onPressed: _facebookSignIn,
              text: "Sign in with Facebook",
              textColor: Colors.white,
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              color: Colors.teal.shade700,
              textColor: Colors.white,
              text: "Sign in with Email",
              onPressed: () => _emailSignIn(context),
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