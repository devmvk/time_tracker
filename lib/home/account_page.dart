import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common/avatar.dart';
import 'package:time_tracker/common/platform_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

class AccountPage extends StatelessWidget {

  AuthBase auth;

  void _signOut() async {
    await auth.signOut();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final _didRequestLogOut = await PlatformAlertDialog(
      content: "Are you sure you want to logout?",
      title: "Logout",
      defalutActionText: "Logout",
    ).show(context);

    if (_didRequestLogOut == true) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthBase>(context);
    final user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Text("Account"),
          ),
        ),
        appBar: AppBar(
          title: Text("Account"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _confirmLogout(context),
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            child: _buildUserInfo(user),
            preferredSize: Size.fromHeight(130),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Avatar(
      photoUrl: user.avatarUrl,
      radius: 50,
    );
  }
}