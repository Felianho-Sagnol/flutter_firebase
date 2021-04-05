import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signInAnonymous() async {
    try {
      final result = await auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> get user async {
    //final user = FirebaseAuth.instance.currentUser;
    //return user;
    return FirebaseAuth.instance.currentUser;
  }

  Future signOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result != null) return true;
      return false;
    } catch (e) {
      print("error de connextion " + e);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result != null) return true;
      return false;
    } catch (e) {
      print("error de connextion " + e);
      return false;
    }
  }
}
