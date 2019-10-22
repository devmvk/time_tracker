import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  CustomRaisedButton({
    this.child,
    this.onPressed,
    this.borderRadius: 2.0,
    this.height: 50.0,
    this.color
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}