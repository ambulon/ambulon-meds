import 'dart:async';
import 'dart:convert';
import 'package:medcomp/models/cart.model.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  String message;

  Future<CartModel> getPrefsData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String cartPref = prefs.getString('cartPref');
      if (cartPref != null) {
        CartModel result = CartModel.fromJson({});
        return result;
      } else {
        return null;
      }
    } catch (e) {
      message = e.toString();
      print("error in get cartPrefs $message");
      throw "error in get cartPrefs $message";
    }
  }

  Future<CartModel> getNetworkData(List<String> list) async {
    try {
      // TODO : save to SP
      var res = await MyHttp.post('/getCartData', {});
      if (res != null) {
        var body = jsonDecode(res.body);
        print(body);
        CartModel result = CartModel.fromJson({});
        return result;
      } else {
        return null;
      }
    } catch (e) {
      message = e.toString();
      print("error in get cartPrefs $message");
      throw "error in get cartPrefs $message";
    }
  }
}
