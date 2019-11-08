
import 'package:flutter/foundation.dart';
import 'package:time_tracker/common/validators.dart';
import 'package:time_tracker/authentication/email_sign_in_model.dart';
import 'package:time_tracker/services/auth.dart';


class EmailSignInChangeModel with EmailAndPasswordValidator, ChangeNotifier{
  String email;
  String password;
  EmailFormType formType;
  bool isLoading;
  bool isSubmitted;
  final AuthBase auth;

  EmailSignInChangeModel({
    this.email : "",
    this.password : "",
    this.formType : EmailFormType.signIn,
    this.isLoading : false,
    this.isSubmitted : false,
    @required this.auth
  });
  
  Future<void> submit() async{
    updateModel(
      isLoading: true,
      isSubmitted: true
    );
    try{
      if(formType == EmailFormType.signIn){
        await auth.emailAndPasswordSignIn(email, password);
      }else{
        await auth.createAccount(email, password);
      }
    }catch (e){
      updateModel(isLoading: false);
      rethrow;
    } 
  }

  void updateEmail(String email) => updateModel(email: email);
  void updatePassword(String password) => updateModel(password: password);

  void toggleFormType() => updateModel(formType: this.formType == EmailFormType.signIn ? EmailFormType.register : EmailFormType.signIn, isSubmitted: false);
  void updateModel({
    String email,
    String password,
    EmailFormType formType,
    bool isLoading,
    bool isSubmitted
  }){
      this.updateWith(
        email: email,
        password: password,
        formType: formType,
        isSubmitted: isSubmitted,
        isLoading: isLoading
      );  
  }

  void updateWith({
    String email,
    String password,
    EmailFormType formType,
    bool isLoading,
    bool isSubmitted
  }){
      this.email = email ?? this.email;
      this.password = password ?? this.password;
      this.formType = formType ?? this.formType;
      this.isLoading  = isLoading ?? this.isLoading;
      this.isSubmitted = isSubmitted ?? this.isSubmitted;
      notifyListeners();
  }

  String get primaryText => formType == EmailFormType.signIn ? "Sign In" : "Create Account";
  String get secondaryText => formType == EmailFormType.signIn ? "Need an Account? Register." : "Have an Account? Sign In";
}
