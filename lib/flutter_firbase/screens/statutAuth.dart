import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sagnolapp/flutter_firbase/services/auth.dart';
import 'package:sagnolapp/flutter_firbase/screens/login.dart';
import 'package:sagnolapp/flutter_firbase/screens/home.dart';

class Statut extends StatefulWidget {
  @override
  _StatutState createState() => _StatutState();
}

class _StatutState extends State<Statut> {
  User user;
  AuthServices auth = AuthServices();

  Future<void> getUser() async {
    final userResult = await auth.user;
    setState(() {
      user = userResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return user == null ? Login() : Home();
  }
}
