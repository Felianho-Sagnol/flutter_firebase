import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sagnolapp/flutter_firbase/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbServices {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection("users");

  //<>
  Future saveUser(UserModel user) async {
    try {
      await usercol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUser(String id) async {
    try {
      final data = await usercol.doc(id).get();
      final user = UserModel.fromJson(data.data());
      return user;
    } catch (e) {
      return null;
    }
  }

  Future updateUser(UserModel user) async {
    try {
      await usercol.doc(user.id).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImage(File file, {String path}) async {
    var time = DateTime.now().toString();
    var ext_ension = Path.basename(file.path).split(".")[1].toString();
    String image = path + "_" + time + "." + ext_ension;
    try {
      Reference ref = FirebaseStorage.instance.ref().child(path + "/" + image);
      UploadTask uploadTask = ref.putFile(file);
      return await (await uploadTask).ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
