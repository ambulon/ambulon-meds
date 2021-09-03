import 'dart:async';
import 'dart:convert';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/models/banner.model.dart';
import 'package:medcomp/models/searchhistory.model.dart';
import 'package:medcomp/models/user.model.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  String message;

  Future<UserModel> getUserDetails() async {
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

  Future<List<BannerModel>> getBanner() async {
    BannerModel banner1 = new BannerModel(image: MyUrl.url('Banner1.jpg'));
    BannerModel banner2 = new BannerModel(image: MyUrl.url('Banner2.jpg'));
    BannerModel banner3 = new BannerModel(image: MyUrl.url('Banner3.jpg'));
    return [banner1, banner2, banner3];
  }

  Future<List<SearchHistoryModel>> searchHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = prefs.getString(AppConfig.prefsSearchHistory);
      if (data == null) {
        return [];
      }
      var list = jsonDecode(data) as List;
      List<SearchHistoryModel> result = [];
      for (var i in list) {
        result.add(new SearchHistoryModel.fromJson(jsonDecode(i)));
      }
      return result;
    } catch (e) {
      message = e.toString();
      print(message);
      return [];
    }
  }
}
