import 'dart:async';

class HomeMedRepo {
  String message;

  Future getDetails() async {
    return;
    // try {
    //   var res = await MyHttp.get("scrape?name=Paracetamol");

    //   if (res.statusCode == 200) {
    //     var resBody = jsonDecode(res.body);
    //     print(resBody['priceList']);
    //     SingleSearchResultModel result = SingleSearchResultModel.fromJson(resBody['priceList'], 'Paracetamol');
    //     return result;
    //   } else {
    //     print("Error code for search repo is ${res.statusCode} ${res.body}");
    //     message = "Error code for search repo is ${res.statusCode} ${res.body}";
    //     throw message;
    //   }
    // } catch (e) {
    //   message = e.toString();
    //   print("error in getDetails $message");
    //   throw "error in getDetails $message";
    // }
  }
}
