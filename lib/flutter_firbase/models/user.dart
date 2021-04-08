class UserModel {
  String id, email, pseudo, image;
  UserModel({this.id, this.email, this.pseudo, this.image});
  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        email: j["email"],
        id: j['id'],
        pseudo: j["pseudo"],
        image: j["image"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "pseudo": pseudo,
        "image": image,
      };
}
