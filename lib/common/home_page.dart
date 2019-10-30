import 'package:flutter/material.dart';
import 'package:time_tracker/common/platform_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {

  final AuthBase auth;


  HomePage({@required this.auth});

  void _signOut() async{
    await auth.signOut();
  }

  Future<void> _confirmLogout(BuildContext context) async{
    final _didRequestLogOut = await PlatformAlertDialog(
      content: "Are you sure you want to logout?",
      title: "Logout",
      defalutActionText: "Logout",
    ).show(context);

    if(_didRequestLogOut == true){
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _confirmLogout(context),
              child: Text("Logout", style: TextStyle(color: Colors.white,),
            ))
          ],
        ),
      ),
    );
  }
}