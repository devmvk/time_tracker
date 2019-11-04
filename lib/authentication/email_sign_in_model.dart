
import 'package:time_tracker/common/validators.dart';

enum EmailFormType{ signIn, register}


class EmailSignInModel with EmailAndPasswordValidator{
  final String email;
  final String password;
  final EmailFormType formType;
  final bool isLoading;
  final bool isSubmitted;

  EmailSignInModel({
    this.email : "",
    this.password : "",
    this.formType : EmailFormType.signIn,
    this.isLoading : false,
    this.isSubmitted : false,
  });

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailFormType formType,
    bool isLoading,
    bool isSubmitted
  }){
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted
    );
  }

  String get primaryText => formType == EmailFormType.signIn ? "Sign In" : "Create Account";
  String get secondaryText => formType == EmailFormType.signIn ? "Need an Account? Register." : "Have an Account? Sign In";
}
