
import 'package:time_tracker/common/custom_raised_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomRaisedButton{
  SignInButton({
    @required String text,
    Color textColor,
    Color color,
    VoidCallback onPressed
  }) : 
  assert(text != null),
  super(
    onPressed: onPressed,
    color: color,
    child: Text(text,
     style: TextStyle(
       color: textColor,
       fontSize: 15.0),
     ),
  );
}