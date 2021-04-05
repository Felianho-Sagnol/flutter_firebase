import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sagnolapp/widgets/customTextField.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final Function visible;
  Register({this.visible});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
  CustomTextField confirmPassText = CustomTextField(
    title: "Confirme Password",
    placeholder: "Confirme Password ...",
    ispass: true,
    error: "enter a valid password.",
  );
  CustomTextField nameText = CustomTextField(
    title: "Nom",
    placeholder: "Nom ...",
    error: "Au moins 2 caractères.",
  );

  Future register(String name, String email, String password) async {
    http.Response response = await http.post(
      Uri.parse("https://sagnolapp.000webhostapp.com/sagnolApp/register.php"),
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //var data = response.body;
      print(data);
      print("yes");
    }
    //print(response.body);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      "Register",
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
                        nameText.textFormField(),
                        passText.textFormField(),
                        SizedBox(height: 20),
                        confirmPassText.textFormField(),
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              register(
                                nameText.value,
                                emailText.value,
                                passText.value,
                              );
                              //print(emailText.value);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Déja un compte ?"),
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
