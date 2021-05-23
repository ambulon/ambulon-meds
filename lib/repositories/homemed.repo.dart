import 'dart:async';
import 'dart:convert';
import 'package:medcomp/models/search.model.dart';
import 'package:medcomp/utils/my_url.dart';

class HomeMedRepo {
  String message;

  Future<SingleSearchResultModel> getDetails() async {
    try {
      var res = await MyHttp.get("scrape?name=Paracetamol");

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        print(resBody['priceList']);
        SingleSearchResultModel result = SingleSearchResultModel.fromJson(resBody['priceList'], 'Paracetamol');
        return result;
      } else {
        print("Error code for search repo is ${res.statusCode} ${res.body}");
        message = "Error code for search repo is ${res.statusCode} ${res.body}";
        throw message;
      }
    } catch (e) {
      message = e.toString();
      print("error in getDetails $message");
      throw "error in getDetails $message";
    }
  }
}
