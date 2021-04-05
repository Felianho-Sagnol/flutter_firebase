import 'package:flutter/material.dart';
//import 'package:sagnolapp/flutter_firbase/screens/login.dart';
import 'package:sagnolapp/flutter_firbase/services/auth.dart';
import 'package:sagnolapp/widgets/customTextField.dart';
import 'package:sagnolapp/flutter_firbase/screens/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthServices auth = AuthServices();

  CustomEmailField emailText = CustomEmailField(
    title: "Email",
    placeholder: "Email ...",
    error: "enter a valid email.",
  );
  CustomTextField passText = CustomTextField(
    title: "Password",
    placeholder: "Password ...",
    ispass: true,
    error: "enter a valid password.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(height: 10.0, color: Colors.black),
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        emailText.emailFormField(),
                        SizedBox(height: 20),
                        passText.textFormField(),
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              loading(context);
                              bool register = await auth.signUp(
                                emailText.value,
                                passText.value,
                              );
                              if (register != null) {
                                Navigator.of(context).pop();
                                if (register) Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          color: Colors.redAccent.withOpacity(.7),
                        ),
                        SizedBox(height: 30),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Déja un compte ?"),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return Login();
                                  }),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
