import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sagnolapp/flutter_firbase/services/auth.dart';
import 'package:sagnolapp/flutter_firbase/screens/login.dart';
import 'package:sagnolapp/flutter_firbase/screens/home.dart';
import 'package:sagnolapp/flutter_firbase/models/user.dart';
import 'package:sagnolapp/flutter_firbase/services/db.dart';

class Statut extends StatefulWidget {
  @override
  _StatutState createState() => _StatutState();
}

class _StatutState extends State<Statut> {
  User user;
  AuthServices auth = AuthServices();
  UserModel userm;

  Future<void> getUser() async {
    final userResult = await auth.user;
    setState(() {
      user = userResult;
    });
  }
  //<>

  @override
  Widget build(BuildContext context) {
    getUser();
    return user == null
        ? Login()
        : StreamProvider<UserModel>.value(
            value: DbServices().getCurentUser,
            child: Home(),
            initialData: userm,
          );
  }
}
