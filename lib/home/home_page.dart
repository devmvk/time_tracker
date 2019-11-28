import 'package:flutter/material.dart';
import 'package:time_tracker/home/cupertiono_home_scaffold.dart';
import 'package:time_tracker/home/job_page.dart';
import 'package:time_tracker/home/tab_item.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

   Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobPage(),
      TabItem.entries: (_) => Container(),
      TabItem.account: (_) => Container(),
    };
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoHomeScaffold(
        onSelectTab: _select,
        currentTab: _currentTab,
        widgetBuilders: widgetBuilders,
      ),
    );
  }
}