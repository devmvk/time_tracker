import 'package:flutter/material.dart';
import 'package:time_tracker/home/account_page.dart';
import 'package:time_tracker/home/cupertiono_home_scaffold.dart';
import 'package:time_tracker/home/entries/entries_page.dart';
import 'package:time_tracker/home/job_page.dart';
import 'package:time_tracker/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  void _select(TabItem tabItem) {
    if(tabItem == _currentTab){
      navigatorKeys[_currentTab].currentState.popUntil((route) => route.isFirst);
    }else{
      setState(() => _currentTab = tabItem);
    }
  }

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobPage(),
      TabItem.entries: (_) => EntriesPage.create(_),
      TabItem.account: (_) => AccountPage(),
    };
  }

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: Container(
        child: CupertinoHomeScaffold(
          onSelectTab: _select,
          currentTab: _currentTab,
          widgetBuilders: widgetBuilders,
          navigatorKeys: navigatorKeys,
        ),
      ),
    );
  }
}
