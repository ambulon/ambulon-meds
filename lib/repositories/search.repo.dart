import 'dart:async';
import 'dart:convert';
// import 'dart:convert';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/models/search.model.dart';
import 'package:medcomp/utils/my_url.dart';
// import 'package:medcomp/utils/my_url.dart';
// import 'dart:developer';

class SearchRepo {
  String message;

  Future<SearchModel> getDetails(strList, dataList) async {
    try {
      var res = await MyHttp.get("user/get-price/${strList.last}");

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        MedicineModel model = new MedicineModel.fromJson(resBody['med']);
        dataList.add(model);
        SearchModel result = new SearchModel(strList, dataList);
        // SearchModel result = mew SearchModel.fromJson(resBody['med'], strList, dataList);
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
