import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sagnolapp/flutter_firbase/services/auth.dart';
import 'package:sagnolapp/flutter_firbase/services/db.dart';
import 'package:sagnolapp/flutter_firbase/models/user.dart';
import 'package:sagnolapp/flutter_firbase/screens/login.dart';
import 'package:sagnolapp/flutter_firbase/screens/menus.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserModel userm;
  bool user_is_null = false;
  AuthServices auth = AuthServices();
  final key = GlobalKey<ScaffoldState>();

  /*Future<void> getUser() async {
    User user = await auth.user;
    final userResult = await DbServices().getUser(user.uid);
    setState(() {
      userm = userResult;
      UserModel.current = userResult;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    if (user_is_null) return Login();
    //getUser();
    userm = Provider.of<UserModel>(context);
    return SafeArea(
      child: Scaffold(
        key: key,
        drawer: Menu(),
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            InkWell(
              onTap: () {
                key.currentState.openDrawer();
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(userm.image),
                    /*: Image(
                            image:
                                AssetImage('images/default-avatar-profile.jpg'),
                          ),*/
                    child: userm.image != null
                        ? Container()
                        : Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Deconnexion"),
                      content: Text("Voulez-vous vous déconnecter?"),
                      actions: [
                        FlatButton(
                          onPressed: () async {
                            await auth.signOut();
                            setState(() {
                              user_is_null = true;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Oui"),
                        ),
                        FlatButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text("Non"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                "LogOut",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcom to our home"),
              /*if (userm != null)
                Text(
                  "id : " + userm.id + "\nemail : " + userm.email,
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
