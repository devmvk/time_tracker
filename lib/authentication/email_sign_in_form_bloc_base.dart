import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/authentication/email_sign_in_bloc.dart';
import 'package:time_tracker/authentication/form_submit_button.dart';
import 'package:time_tracker/common/platform_exception_alert_dialog.dart';
import 'package:time_tracker/authentication/email_sign_in_model.dart';
import 'package:time_tracker/services/auth.dart';


class EmailSignInFormBlocBased extends StatefulWidget {

  final EmailSignInBloc bloc;

  EmailSignInFormBlocBased({@required this.bloc});

  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
      builder: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (BuildContext _, EmailSignInBloc bloc, Widget child) => EmailSignInFormBlocBased(
          bloc: bloc,
        ),
      ),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() => _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  
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
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _submit() async{
    try{
      await widget.bloc.submit();
      Navigator.of(context).pop();
    }on PlatformException catch (e){
      PlatformExceptionAlertDialog(exception: e, title: "Sign In Failed",).show(context);
    }
  }

  List<Widget> _buildChildren({@required EmailSignInModel model}){
    
    return [
      _buildEmailField(model: model),
      SizedBox(height: 8.0,),
      _buildPasswordField(model: model),
      SizedBox(height: 8.0,),
      FormSignInButton(
        text: model.primaryText,
        onPressed: model.isLoading ? null : _submit,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        child: Text(model.secondaryText),
        onPressed: model.isLoading ? null : _toggleFormType,
      )
    ];
  }

  TextField _buildPasswordField({@required EmailSignInModel model}) {
    bool _showPasswordErrorText = model.isSubmitted && !model.passwordValidator.isValid(model.email);
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: _showPasswordErrorText ? model.passwordErrorText : null
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailField({@required EmailSignInModel model}) {
    bool _showEmailErrorText = model.isSubmitted && !model.emailValidator.isValid(model.email);

    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: _showEmailErrorText ? model.emailErrorText : null
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
      child: StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (BuildContext context, AsyncSnapshot<EmailSignInModel> snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(model: snapshot.data),
          );
        }
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