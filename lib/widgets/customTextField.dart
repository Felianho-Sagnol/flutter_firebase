import 'package:flutter/material.dart';

class CustomTextField {
  final String title;
  final String placeholder;
  final bool ispass;
  String error;
  String _value;
  CustomTextField({
    this.title = "",
    this.placeholder = "",
    this.ispass = false,
    this.error = "Obligatoire .... !!!!",
  });
  TextFormField textFormField() {
    return TextFormField(
      obscureText: this.ispass,
      decoration: InputDecoration(
        hintText: this.placeholder,
        labelText: this.title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(1),
          ),
        ),
      ),
      onChanged: (e) {
        _value = e;
      },
      validator: (e) {
        return e.isEmpty ? this.error : null;
      },
    );
  }

  String get value {
    return _value;
  }
}

class CustomEmailField {
  final String title;
  final String placeholder;
  String error;
  String _value;
  CustomEmailField({
    this.title = "",
    this.placeholder = "",
    this.error = "Obligatoire .... !!!!",
  });
  TextFormField emailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: this.placeholder,
        labelText: this.title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(1),
          ),
        ),
      ),
      onChanged: (e) {
        _value = e;
      },
      validator: (e) {
        return e.isEmpty ? this.error : null;
      },
    );
  }

  String get value {
    return _value;
  }
}
