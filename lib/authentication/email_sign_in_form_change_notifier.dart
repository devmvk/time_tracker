import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/authentication/email_sign_in_change_model.dart';
import 'package:time_tracker/authentication/form_submit_button.dart';
import 'package:time_tracker/common/platform_exception_alert_dialog.dart';
import 'package:time_tracker/authentication/email_sign_in_model.dart';
import 'package:time_tracker/services/auth.dart';


class EmailSignInFormChangeNotifier extends StatefulWidget {

  final EmailSignInChangeModel model;

  EmailSignInFormChangeNotifier({@required this.model});

  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      builder: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (BuildContext _, EmailSignInChangeModel model, Widget child) => EmailSignInFormChangeNotifier(
          model: model,
        ),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() => _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState extends State<EmailSignInFormChangeNotifier> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
   

  void _focusOnPasswordField({@required EmailSignInModel model}){
    //   TODO  method call correction;

    FocusNode _toggleNode = model.emailValidator.isValid(model.email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(_toggleNode);
  }

  void _toggleFormType(){
    widget.model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _submit() async{
    try{
      await widget.model.submit();
      Navigator.of(context).pop();
    }on PlatformException catch (e){
      PlatformExceptionAlertDialog(exception: e, title: "Sign In Failed",).show(context);
    }
  }

  List<Widget> _buildChildren(){
    
    return [
      _buildEmailField(),
      SizedBox(height: 8.0,),
      _buildPasswordField(),
      SizedBox(height: 8.0,),
      FormSignInButton(
        text: widget.model.primaryText,
        onPressed: widget.model.isLoading ? null : _submit,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        child: Text(widget.model.secondaryText),
        onPressed: widget.model.isLoading ? null : _toggleFormType,
      )
    ];
  }

  TextField _buildPasswordField() {
    bool _showPasswordErrorText = widget.model.isSubmitted && !widget.model.passwordValidator.isValid(widget.model.email);
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: _showPasswordErrorText ? widget.model.passwordErrorText : null
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailField() {
    bool _showEmailErrorText = widget.model.isSubmitted && !widget.model.emailValidator.isValid(widget.model.email);

    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: _showEmailErrorText ? widget.model.emailErrorText : null
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
      )
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