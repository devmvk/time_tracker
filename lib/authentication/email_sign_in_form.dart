import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/form_submit_button.dart';
import 'package:time_tracker/services/auth.dart';


enum EmailFormType{ signIn, register}

class EmailSignInForm extends StatefulWidget {

  final AuthBase auth;

  EmailSignInForm({@required this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  EmailFormType _formType = EmailFormType.signIn;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async{
    try{
      if(_formType == EmailFormType.signIn){
        await widget.auth.emailAndPasswordSignIn(_email, _password);
      }else{
        await widget.auth.createAccount(_email, _password);
      }
    }catch (e){
      print(e.toString());
    }
    Navigator.of(context).pop();
  }

  void _toggleFormType(){
    setState(() {
      _formType = _formType == EmailFormType.signIn ? EmailFormType.register : EmailFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(){
    String _primaryText = _formType == EmailFormType.signIn ? "Sign In" : "Create Account";
    String _secondaryText = _formType == EmailFormType.signIn ? "Need an Account? Register." : "Have an Account? Sign In";

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com'
        ),
      ),
      SizedBox(height: 8.0,),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password'
        ),
        obscureText: true,
      ),
      SizedBox(height: 8.0,),
      FormSignInButton(
        text: _primaryText,
        onPressed: _submit,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        child: Text(_secondaryText),
        onPressed: _toggleFormType,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}