import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagnolapp/flutter_firbase/models/user.dart';
import 'package:sagnolapp/flutter_firbase/services/db.dart';
import 'package:sagnolapp/flutter_firbase/services/utils/getImages.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    //final user = UserModel.current;
    final user = Provider.of<UserModel>(context);
    return Container(
      width: 200,
      color: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.pseudo ?? "Aucun nom"),
            accountEmail: Text(user.email ?? "Aucun email"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: user.image != null
                  ? NetworkImage(user.image)
                  : Image(
                      image: AssetImage('images/default-avatar-profile.jpg'),
                    ),
              child: Stack(
                children: [
                  if (user.image == null)
                    Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                  if (loading)
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  Positioned(
                    top: 34,
                    left: 13,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        final data = await showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return GetImage();
                          },
                        );
                        if (data != null) {
                          loading = true;
                          setState(() {});
                          String urlImage = await DbServices()
                              .uploadImage(data, path: "profil");
                          //print(urlImage);
                          if (urlImage != null) {
                            final updateUser = user;
                            updateUser.image = urlImage;
                            bool isupdate =
                                await DbServices().updateUser(updateUser);
                            if (isupdate) {
                              loading = false;
                              setState(() {});
                            }
                          }
                        }
                        //print(data);
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
