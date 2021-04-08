import 'package:flutter/material.dart';
import 'package:sagnolapp/flutter_firbase/services/auth.dart';
import 'package:sagnolapp/flutter_firbase/screens/register.dart';
import 'package:sagnolapp/flutter_firbase/screens/loading.dart';
import 'package:sagnolapp/widgets/customTextField.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthServices auth = AuthServices();
  CustomEmailField email = CustomEmailField(
    title: "Email",
    placeholder: "Votre addresse email .",
    error: "Donner une adrresse email valide",
  );
  CustomTextField password = CustomTextField(
    title: "Mot de passe",
    placeholder: "**********",
    ispass: true,
    error: "le mot de passe doit contenir au moins 6 caractères.",
  );
  String erroMessage = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.black, height: 20),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      email.emailFormField(),
                      SizedBox(height: 20),
                      password.textFormField(),
                      SizedBox(height: 20),
                      Text(
                        (erroMessage.length != 0) ? erroMessage : "",
                        style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            //loading(context);
                            bool login = await auth.signIn(
                              email.value,
                              password.value,
                            );
                            if (login != null) {
                              if (login) {
                                //Navigator.of(context).pop();
                              } else {
                                setState(() {
                                  erroMessage =
                                      "Erreur : Verifiez bien que vous avez un compte avec cette adresse email et ce mot le mot de passe.";
                                });
                              }
                            }
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Colors.redAccent.withOpacity(.7),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pas encore de compte ?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return Register();
                            }),
                          );
                        },
                        child: Text(
                          "Créer un compte.",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.redAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
