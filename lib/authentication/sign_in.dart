import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/authentication/email_sign_in_page.dart';
import 'package:time_tracker/authentication/sign_in_bloc.dart';
import 'package:time_tracker/authentication/sign_in_button.dart';
import 'package:time_tracker/authentication/social_sign_in_button.dart';
import 'package:time_tracker/common/platform_exception_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

class SignInView extends StatelessWidget {

  final SignInBloc bloc;
  final bool isLoading;

  const SignInView({Key key, @required this.bloc, @required this.isLoading}) : super(key: key);

  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      builder: (_) => ValueNotifier<bool>(false),
      child: Consumer(
        builder: (_, ValueNotifier<bool> isLoading, __) => Provider<SignInBloc>(
          builder: (_) => SignInBloc(auth: auth, isLoading: isLoading),
          child: Consumer<SignInBloc>(
            builder: (context, bloc, _) => SignInView(bloc: bloc, isLoading: isLoading.value,)
          ),
        ),
      ),
    );
  }

  
  void _showError(BuildContext context, PlatformException exception){
    PlatformExceptionAlertDialog(
      exception: exception,
      title: "Sign In Failed",
    ).show(context);
  }

  void _signInAnonymously (BuildContext context) async{
    try{
      await bloc.signInAnonymously();
    }on PlatformException catch (e){
      _showError(context, e);
    }catch(e){
      print(e.toString());
    }
  }

  void _googleSignIn(BuildContext context) async{
    try{
      await bloc.googleSignIn();
    }on PlatformException catch (e){
      _showError(context, e);
    }catch(e){
      print(e.toString());
    }

  }

  void _facebookSignIn(BuildContext context) async{
    try{
      await bloc.facebookSignIn();
    }on PlatformException catch (e){
      _showError(context, e);
    }catch(e){
      print(e.toString());
    }
  }

  void _emailSignIn(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => EmailSignIn()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    //final _isLoading = Provider.of<ValueNotifier<bool>>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Time Tracker"),
          centerTitle: true,
        ),  
        body: _buildScreen(context)
      ),
    );
  }

  Container _buildScreen(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildHeader(),
            SizedBox(
              height: 48.0,
            ),
            // for commit
            SocialSignInButton(
              assetName: "images/google-logo.png",
              color: Colors.white,
              onPressed: isLoading ? null : () => _googleSignIn(context),
              text: "Sign in with Google",
              textColor: Colors.black87,
            ),

            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              assetName: "images/facebook-logo.png",
              color: Color(0xFF334D92),
              onPressed: isLoading ? null : () => _facebookSignIn(context),
              text: "Sign in with Facebook",
              textColor: Colors.white,
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              color: Colors.teal.shade700,
              textColor: Colors.white,
              text: "Sign in with Email",
              onPressed: isLoading ? null : () => _emailSignIn(context),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text("or", textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0, color: Colors.black87),),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              color: Colors.lime.shade300,
              textColor: Colors.black87,
              text: "Go anonymous",
              onPressed: isLoading ? null : () =>  _signInAnonymously(context),
            )
          ],
        ),
      );
  }

  Widget _buildHeader() {
    if(isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text("Sign In",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600
      ),
    );
  }
}