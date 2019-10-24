import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthBase{

  Future<User> currentUser();
  Future<User> signIn();
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;

}

class User{
  final String uid;
  User({@required this.uid});
}

class Auth implements AuthBase{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChanged{
    return _auth.onAuthStateChanged.map((_fbUser) => _fbUser != null ? User(uid: _fbUser.uid) : null);
  }

  @override Future<User> currentUser() async{
    return _auth.currentUser()
      .then((_fbUser) => _fbUser != null ? User(uid: _fbUser.uid) : null)
      .catchError((e){print(e.toString());});
  }

  @override Future<User> signIn() async{
    return _auth.signInAnonymously()
      .then((_fbAuth) => User(uid: _fbAuth.user.uid))
      .catchError((e){print(e.toString());});
  }

  @override Future<void> signOut(){
    return _auth.signOut();
  }

}