import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class AuthBase{

  Future<User> currentUser();
  Future<User> signIn();
  Future<void> signOut();
  Future<User> googleSignIn();
  Future<User> facebookSignIn();
  Future<User> emailAndPasswordSignIn(String email, String password);
  Future<User> createAccount(String email, String password);
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
    GoogleSignIn _gSignIn = GoogleSignIn();
    _gSignIn.isSignedIn().then((bool isSignedIn){
      if(isSignedIn) _gSignIn.signOut();
    });
    FacebookLogin _fLogin = FacebookLogin();
    _fLogin.isLoggedIn..then((bool isSignedIn){
      if(isSignedIn) _fLogin.logOut();
    });
    return _auth.signOut();
  }

  @override Future<User> googleSignIn() async{
    try{
      GoogleSignIn _gSignIn = GoogleSignIn();
      GoogleSignInAccount _gAccount = await _gSignIn.signIn();
      if(_gAccount != null){
        GoogleSignInAuthentication _gAuthentication = await _gAccount.authentication;
         return _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: _gAuthentication.idToken,
            accessToken: _gAuthentication.accessToken
          )
        ).then<User>((AuthResult _) => _.user != null ? User(uid: _.user.toString()) : null);
      }else{
        throw StateError("");
      }
    }catch (e){
      throw Exception(e.toString());
    }
    
  }

  @override Future<User> facebookSignIn() async{
    try{
      final FacebookLogin _fLogin = FacebookLogin();
      final FacebookLoginResult  _result = await _fLogin.logIn(['public_profile']);

      switch(_result.status){
        case FacebookLoginStatus.loggedIn:
          return _auth.signInWithCredential(
            FacebookAuthProvider.getCredential(
              accessToken: _result.accessToken.token
            )
          ).then<User>((AuthResult _) => _.user != null ? User(uid: _.user.toString()) : null);
          break;
        case FacebookLoginStatus.cancelledByUser:
          throw StateError("User Cancelled");
          break;
        case FacebookLoginStatus.error:
          throw StateError("Error");
          break;
      }
    }catch (e){
      throw Exception(e.toString());
    }
  }

  @override Future<User> createAccount(String email, String password) async{
    try{
      return _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then<User>((AuthResult _) => _.user != null ? User(uid: _.user.toString()) : null);
    }catch (e){
      throw Exception(e.toString());
    }
  }

  @override Future<User> emailAndPasswordSignIn(String email, String password) async{
    try{
      return _auth.signInWithEmailAndPassword(email: email, password: password)
      .then<User>((AuthResult _) => _.user != null ? User(uid: _.user.toString()) : null);
    }catch (e){
      throw Exception(e.toString());
    }
  }

}