import 'dart:async';
import 'dart:convert';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/models/banner.model.dart';
import 'package:medcomp/models/coupons.model.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/models/searchhistory.model.dart';
import 'package:medcomp/models/user.model.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponsRepo {
  String message;

  Future<List<CouponsModel>> getData() async {
    try {
      var res = await MyHttp.get("user/get-coupons");
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        List<CouponsModel> result = [];
        print(resBody);
        for (var r in resBody["_1mg"] ?? []) {
          result.add(new CouponsModel.fromJson(r));
        }
        for (var r in resBody["netmeds"] ?? []) {
          result.add(new CouponsModel.fromJson(r));
        }
        for (var r in resBody["apollo"] ?? []) {
          result.add(new CouponsModel.fromJson(r));
        }
        return result;
      } else {
        print("Error code for Coupons repo is ${res.statusCode} ${res.body}");
        return [];
      }
    } catch (e) {
      print("error here $e");
      return [];
    }
  }
}
