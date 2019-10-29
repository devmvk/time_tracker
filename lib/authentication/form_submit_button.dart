import 'package:flutter/material.dart';
import 'package:time_tracker/common/custom_raised_button.dart';

class FormSignInButton extends CustomRaisedButton {
  FormSignInButton({
    @required String text,
    VoidCallback onPressed,
  }): super(
    child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20.0),),
    color: Colors.indigo,
    onPressed:onPressed,
    borderRadius: 4.0
  );
}