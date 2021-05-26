import 'dart:async';
import 'dart:convert';
import 'package:medcomp/models/cart.model.dart';
import 'package:medcomp/utils/my_url.dart';

class CartRepo {
  String message;

  // TODO : replace throw w null
  Future<CartModel> getData() async {
    try {
      var res = await MyHttp.get('user/get-cart');
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        CartModel result = CartModel.fromJson(body);
        if (result.items == []) {
          return null;
        }
        return result;
      } else {
        message = res.statusCode.toString() + ";" + res.body.toString();
        print("error in getData $message");
        throw "error in getData $message";
        // return null;
      }
    } catch (e) {
      message = e.toString();
      print("error in getData $message");
      throw "error in getData $message";
    }
  }

  Future<bool> addItem(var data) async {
    try {
      var res = await MyHttp.post('user/add-to-cart', data);
      if (res.statusCode == 200) {
        return true;
      } else {
        message = res.statusCode.toString() + ";" + res.body.toString();
        print("error in removeiten $message");
        return false;
      }
    } catch (e) {
      message = e.toString();
      print("error in get removeiten $message");
      return false;
    }
  }

  Future<bool> removeItem(String name) async {
    try {
      var data = {"name": name};
      var res = await MyHttp.post('user/remove-from-cart', data);
      if (res.statusCode == 200) {
        return true;
      } else {
        message = res.statusCode.toString() + ";" + res.body.toString();
        print("error in removeiten $message");
        return false;
      }
    } catch (e) {
      message = e.toString();
      print("error in get removeiten $message");
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      var res = await MyHttp.get('user/clear-cart');
      if (res.statusCode == 200) {
        return true;
      } else {
        message = res.statusCode.toString() + ";" + res.body.toString();
        print("error in clear cart $message");
        throw "error in clear cart $message";
      }
    } catch (e) {
      message = e.toString();
      print("error in clear cart $message");
      throw "error in clear cart $message";
    }
  }
}
