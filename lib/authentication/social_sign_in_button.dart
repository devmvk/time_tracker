
import 'package:time_tracker/common/custom_raised_button.dart';
import 'package:flutter/material.dart';

class SocialSignInButton extends CustomRaisedButton{
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color textColor,
    Color color,
    VoidCallback onPressed
  }) : super(
    onPressed: onPressed,
    color: color,
    child: Row(
      children: <Widget>[
        Image.asset(assetName),
        Expanded(child: SizedBox(),),
        Text(text,
          style: TextStyle(
            color: textColor,
            fontSize: 15.0),
          ),
        Expanded(child: SizedBox(),)
      ],
    ),
  );
}