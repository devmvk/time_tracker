
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:time_tracker/services/auth.dart';

class SignInBloc{
  final AuthBase auth;
  SignInBloc({@required this.auth});
  
  StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream get isLoading => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  void _setLoadingState(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async{
    try{
      _setLoadingState(true);
      return await signInMethod();
    }catch(e){
      rethrow;
    }finally{
      _setLoadingState(false);
    }
  }

  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);
  Future<User> googleSignIn() async => await _signIn(auth.facebookSignIn);
  Future<User> facebookSignIn() async => await _signIn(auth.googleSignIn);
}