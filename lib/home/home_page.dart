import 'package:flutter/material.dart';
import 'package:time_tracker/home/cupertiono_tab_scaffold.dart';

enum TabItem{job, entries, account}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentItem = TabItem.job;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoHomeScaffold(
        onSelected: (item){},
        tabItem: _currentItem,
      ),
    );
  }
}