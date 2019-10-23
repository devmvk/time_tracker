import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
        appBar: AppBar(
          title: Text("Home"),
        ),
      ),
    );
  }
}