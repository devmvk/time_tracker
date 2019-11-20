import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String title;
  final String content;

  const EmptyContent({Key key, this.title = "No values", this.content = " Add new values"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 32),),
          Text(title, style: TextStyle(fontSize: 16),)
        ],
      ),
    );
  }
}