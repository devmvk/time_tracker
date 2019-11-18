import 'package:flutter/material.dart';
import 'package:time_tracker/common/platform_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:provider/provider.dart';
class JobPage extends StatelessWidget {

  AuthBase auth;

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
    auth = Provider.of<AuthBase>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(),
        appBar: AppBar(
          title: Text("Jobs"),
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