import 'package:flutter/material.dart';
import 'package:time_tracker/authentication/form_submit_button.dart';
import 'package:time_tracker/common/validators.dart';
import 'package:time_tracker/authentication/email_sign_in_model.dart';


class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  
  EmailFormType _formType = EmailFormType.signIn;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  bool _isSubmitted = false;
  bool _isLoading = false;

  

  void _focusOnPasswordField(){
    FocusNode _toggleNode = widget.emailValidator.isValid(_email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(_toggleNode);
  }

  Future<void> _submit() async{
    // try{
    //   //await widget.model.submit();
    //   Navigator.of(context).pop();
    // }on PlatformException catch (e){
    //   PlatformExceptionAlertDialog(exception: e, title: "Sign In Failed",).show(context);
    // }
  }

  void _toggleFormType(){
    setState(() {
      _isSubmitted = false;
      _formType = _formType == EmailFormType.signIn ? EmailFormType.register : EmailFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(){
    String _primaryText = _formType == EmailFormType.signIn ? "Sign In" : "Create Account";
    String _secondaryText = _formType == EmailFormType.signIn ? "Need an Account? Register." : "Have an Account? Sign In";

    return [
      _buildEmailField(),
      SizedBox(height: 8.0,),
      _buildPasswordField(),
      SizedBox(height: 8.0,),
      FormSignInButton(
        text: _primaryText,
        onPressed: _isLoading ? null : _submit,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        child: Text(_secondaryText),
        onPressed: _isLoading ? null : _toggleFormType,
      )
    ];
  }

  TextField _buildPasswordField() {
    bool _showPasswordErrorText = _isSubmitted && !widget.passwordValidator.isValid(_email);
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: _showPasswordErrorText ? widget.passwordErrorText : null
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailField() {
    bool _showEmailErrorText = _isSubmitted && !widget.emailValidator.isValid(_email);

    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: _showEmailErrorText ? widget.emailErrorText : null
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: _focusOnPasswordField,
    );
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}