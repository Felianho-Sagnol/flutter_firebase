import 'dart:convert';
//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:sagnolapp/widgets/customTextField.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  final Function visible;
  Login({this.visible});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  CustomTextField emailText = CustomTextField(
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future login(String email, String pass) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    http.Response response = await http.get(
      Uri.parse("https://sagnolapp.000webhostapp.com/sagnolApp/connexion.php"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      //var data = json.decode(response.body);
      //print(data);
      print("yes");
    } else {
      print("no");
    }
    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Login",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(height: 2.0, color: Colors.black),
                    SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        emailText.textFormField(),
                        SizedBox(height: 20),
                        passText.textFormField(),
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () {
                            login("", "");
                            /*if (_formKey.currentState.validate()) {
                              print(emailText.value);
                            }*/
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          color: Colors.redAccent.withOpacity(.7),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pas de Compte ?"),
                            FlatButton(
                              onPressed: widget.visible,
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
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
