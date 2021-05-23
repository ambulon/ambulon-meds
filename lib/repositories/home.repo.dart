import 'dart:async';
import 'dart:convert';
import 'package:medcomp/models/user.model.dart';
import 'package:medcomp/utils/my_url.dart';

class HomeRepo {
  String message;

  Future<UserModel> getDetails() async {
    try {
      var res = await MyHttp.get("user/get-details");
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        UserModel user = new UserModel.fromJson(resBody["user"]);
        print("home.repo ran fine");
        return user;
      } else {
        print("Error code for home repo is ${res.statusCode} ${res.body}");
        message = "Error code for home repo is ${res.statusCode} ${res.body}";
        return null;
      }
    } catch (e) {
      message = e.toString();
      print(message);
      return null;
    }
  }
}
