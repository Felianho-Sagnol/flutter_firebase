import 'package:firebase_auth/firebase_auth.dart';
import 'package:sagnolapp/flutter_firbase/services/db.dart';
import 'package:sagnolapp/flutter_firbase/models/user.dart';

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
      print("error de deconnexion");
      return null;
    }
  }

  Future<bool> signUp(String email, String password, String pseudo) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        await DbServices().saveUser(UserModel(
          id: result.user.uid,
          email: result.user.email,
          pseudo: pseudo,
        ));
        return true;
      }
      return false;
    } catch (e) {
      print("error de connextion lors de l'enregistrement " + e);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) return true;
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        // Do something :D
        print("error de connextion lors de la connexion" + e.message);
        return false;
      }
    } catch (e) {
      print("error de connextion lors de la connexion" + e.message);
      return false;
    }
  }
}
