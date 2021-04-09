import 'package:flutter/material.dart';
import 'package:sagnolapp/flutter_firbase/services/auth.dart';
import 'package:sagnolapp/flutter_firbase/screens/register.dart';
import 'package:sagnolapp/flutter_firbase/screens/loading.dart';
import 'package:sagnolapp/widgets/customTextField.dart';
import 'package:sagnolapp/flutter_firbase/models/user.dart';
import 'package:provider/provider.dart';
import 'package:sagnolapp/flutter_firbase/services/db.dart';
import 'package:sagnolapp/flutter_firbase/screens/home.dart';

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
  CustomPassWordField password = CustomPassWordField(
    title: "Mot de passe",
    placeholder: "**********",
    ispass: true,
    error: "le mot de passe doit contenir au moins 6 caractères.",
  );
  String erroMessage = "";
  UserModel userm;

  @override
  Widget build(BuildContext context) {
    userm = Provider.of<UserModel>(context);
    return userm != null
        ? StreamProvider<UserModel>.value(
            value: DbServices().getCurentUser,
            child: Home(),
            initialData: userm,
          )
        : SafeArea(
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
                            SizedBox(height: 10),
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
                                  String login = await auth.signIn(
                                    email.value,
                                    password.value,
                                  );
                                  if (login != null) {
                                    if (login.length != 0) {
                                      //Navigator.of(context).pop();
                                      setState(() {
                                        erroMessage = login;
                                      });
                                    } else {
                                      setState(() {
                                        erroMessage = "";
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
