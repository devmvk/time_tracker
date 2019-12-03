import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';
import 'package:time_tracker/authentication/email_sign_in_model.dart';
//import 'package:time_tracker/authentication/email_sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

class EmailSignInBloc {
  final BehaviorSubject<EmailSignInModel> _modelSubject =
      BehaviorSubject<EmailSignInModel>.seeded(EmailSignInModel());
  final AuthBase auth;

  EmailSignInBloc({@required this.auth});

  Stream<EmailSignInModel> get modelStream => _modelSubject.stream;
  EmailSignInModel get _model => _modelSubject.value;

  void dispose() {
    _modelSubject.close();
  }

  Future<void> submit() async {
    updateModel(isLoading: true, isSubmitted: true);
    try {
      if (_model.formType == EmailFormType.signIn) {
        await auth.emailAndPasswordSignIn(_model.email, _model.password);
      } else {
        await auth.createAccount(_model.email, _model.password);
      }
    } catch (e) {
      updateModel(isLoading: false);
      rethrow;
    }
  }

  void updateModel(
      {String email,
      String password,
      EmailFormType formType,
      bool isLoading,
      bool isSubmitted}) {
    _modelSubject.add(
      _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isSubmitted: isSubmitted,
        isLoading: isLoading,
      ),
    );
  }

  void updateEmail(String email) => updateModel(email: email);
  void updatePassword(String password) => updateModel(password: password);

  void toggleFormType() => updateModel(
      formType: _model.formType == EmailFormType.signIn
          ? EmailFormType.register
          : EmailFormType.signIn,
      isSubmitted: false);
}
