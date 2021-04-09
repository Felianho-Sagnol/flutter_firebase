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

  Future<String> signUp(String email, String password, String pseudo) async {
    String errorMessage = "";
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        await DbServices().saveUser(
          UserModel(
            id: result.user.uid,
            email: result.user.email,
            pseudo: pseudo,
            image:
                "https://firebasestorage.googleapis.com/v0/b/sagnosocialapp.appspot.com/o/profil%2Fdefault-avatar-profile.jpg?alt=media&token=bd46c265-a7fa-4972-8435-1204a1b8d8f8",
          ),
        );
        //return true;
        errorMessage = "";
      } else {
        //return false;
        errorMessage =
            "ERREUR : Une erreur est survenue lors de l'enregistrement pretez attention à la validité de votre addresse email fournie.";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorMessage =
            "ERREUR : Cette addresse email est dèjà utilisé pour un autre compte.";
      }
    } catch (e) {
      errorMessage =
          "Une erreur est survenue lors de l'enregistrement pretez attention à la validité de votre addresse email fournie.";
    }
    return errorMessage;
  }

  Future<String> signIn(String email, String password) async {
    String errorMessage = "";
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        //return true;
        errorMessage = "";
      } else {
        //return false;
        errorMessage =
            "Erreur : Verifiez bien que vous avez un compte avec cette adresse email et ce mot le mot de passe.";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        errorMessage =
            "ERREUR : Aucun utilisateur n'a été trouvé avec cette addresse email. Veillez créer un compte pour vous connecter.";
      }
    } catch (e) {
      //return false;
      errorMessage =
          "Erreur : Verifiez bien que vous avez un compte avec cette adresse email et ce mot le mot de passe.";
    }

    return errorMessage;
  }
}
