import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/email_sign_in_form_change_notifier.dart';

class EmailSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Email SignIn"),
          centerTitle: true,
        ),  
        body: EmailSignInFormChangeNotifier.create(context),
      ),
    );
  }
}