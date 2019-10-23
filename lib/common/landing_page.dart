import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/sign_in.dart';
import 'package:time_tracker/common/home_page.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  LandingPage({@required this.auth});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async{
    _user = await widget.auth.currentUser();
    _updateAuthentication(_user);
  }

  void _updateAuthentication(User user){
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return SignInView(
        onSignIn: _updateAuthentication,
        auth: widget.auth,
      );
    }else{
      return HomePage(
        onSignOut: () => _updateAuthentication(null),
        auth: widget.auth,
      );
    }
  }
}