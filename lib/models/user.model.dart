import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String id;
  String fid;
  String name;
  String email;
  String photoUrl;
  List last10searches;
  // List<MedicineModel> wishlist;

  UserModel(
    this.id,
    this.fid,
    this.name,
    this.email,
    this.photoUrl,
    this.last10searches,
  );

  UserModel.fromJson(Map<String, dynamic> json) {
    String imageTemp;
    try {
      imageTemp = json["imageUrl"];
    } catch (e) {}
    if (imageTemp == null) {
      imageTemp = "https://i.pravatar.cc/300";
    }

    UserModel(
      this.id = json["_id"] ?? 'null',
      this.fid = json["f_id"] ?? "null",
      this.name = json["name"] ?? "null",
      this.email = json["email"] ?? "null",
      this.photoUrl = imageTemp,
      this.last10searches = json["search_history"],
    );
  }
}
