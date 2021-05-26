import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class MyUrl {
  static String url(String endPoint) {
    if (endPoint.substring(0, 1) == "/") endPoint = endPoint.substring(1);
    return "https://ambulon-meds.herokuapp.com/$endPoint";
    // return "https://be1360e912d8.ngrok.io/$endPoint";
  }
}

class MyHttp {
  static Future<http.Response> put(String endPoint, dynamic data) async {
    var sp = await SharedPreferences.getInstance();
    // String token = sp.getString("token");
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MGE5ZTJiYThjZTQ1YTAwMTVlMjk5YTAiLCJmX2lkIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjIxNzQ3MTgzfQ.bIige5tBPkRAHDDPjzrdUdk-M99iJsEfzwtLUdffkyg";
    var headers = {"Content-type": "application/json", "authorization": "Bearer $token"};
    var res = await http.put(MyUrl.url(endPoint), body: convert.jsonEncode(data), headers: headers);
    return res;
  }

  static Future<http.Response> patch(String endPoint, dynamic data) async {
    var sp = await SharedPreferences.getInstance();
    // String token = sp.getString("token");
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MGE5ZTJiYThjZTQ1YTAwMTVlMjk5YTAiLCJmX2lkIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjIxNzQ3MTgzfQ.bIige5tBPkRAHDDPjzrdUdk-M99iJsEfzwtLUdffkyg";
    var headers = {"Content-type": "application/json", "authorization": "Bearer $token"};
    var res = await http.patch(MyUrl.url(endPoint), body: convert.jsonEncode(data), headers: headers);
    return res;
  }

  static Future<http.Response> delete(String endPoint) async {
    var sp = await SharedPreferences.getInstance();
    // String token = sp.getString("token");
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MGE5ZTJiYThjZTQ1YTAwMTVlMjk5YTAiLCJmX2lkIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjIxNzQ3MTgzfQ.bIige5tBPkRAHDDPjzrdUdk-M99iJsEfzwtLUdffkyg";
    var headers = {"Content-type": "application/json", "authorization": "Bearer $token"};
    var res = await http.delete(MyUrl.url(endPoint), headers: headers);
    return res;
  }

  static Future<http.Response> post(String endPoint, dynamic data) async {
    var sp = await SharedPreferences.getInstance();
    // String token = sp.getString("token");
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MGE5ZTJiYThjZTQ1YTAwMTVlMjk5YTAiLCJmX2lkIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjIxNzQ3MTgzfQ.bIige5tBPkRAHDDPjzrdUdk-M99iJsEfzwtLUdffkyg";
    var headers = {"Content-type": "application/json", "authorization": "Bearer $token"};
    print(token);
    return await http.post(MyUrl.url(endPoint), body: convert.jsonEncode(data), headers: headers);
  }

  static Future<http.Response> get(String endPoint) async {
    var sp = await SharedPreferences.getInstance();
    // String token = sp.getString("token");
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MGE5ZTJiYThjZTQ1YTAwMTVlMjk5YTAiLCJmX2lkIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjIxNzQ3MTgzfQ.bIige5tBPkRAHDDPjzrdUdk-M99iJsEfzwtLUdffkyg";
    print(token);
    var headers = {"Content-type": "application/json", "authorization": "Bearer $token"};
    var res = await http.get(MyUrl.url(endPoint), headers: headers);
    return res;
  }
}
