import 'package:firebase_auth/firebase_auth.dart';
import 'package:imageCollector/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginUser _userFromFirebaseUser(User user) {
    return user != null ? LoginUser(uid: user.uid) : null;
  }

  Stream<LoginUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Login User

  Future signInwithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //Create User

  Future createwithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
