import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sagnolapp/flutter_firbase/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () async {
                await auth.signOut();
                setState(() {});
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcom to our home"),
              if (user != null) Text("uid : " + user.uid),
            ],
          ),
        ),
      ),
    );
  }
}
