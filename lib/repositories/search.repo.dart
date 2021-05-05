import 'dart:async';
import 'dart:convert';
// import 'dart:convert';
import 'package:medcomp/models/search.model.dart';
import 'package:medcomp/utils/my_url.dart';
// import 'package:medcomp/utils/my_url.dart';
// import 'dart:developer';

class SearchRepo {
  String message;

  Future<SearchModel> getDetails(strList, dataList) async {
    // await Future.delayed(new Duration(milliseconds: 500));
    // SearchModel result = SearchModel.fromJson({}, strList, dataList);
    // return result;
    try {
      var res = await MyHttp.get("scrape?name=${strList.last}");

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        print("scrape body for ${strList.last} : $resBody");
        SearchModel result = SearchModel.fromJson([resBody], strList, dataList);
        return result;
      } else {
        print("Error code for search repo is ${res.statusCode} ${res.body}");
        message = "Error code for search repo is ${res.statusCode} ${res.body}";
        return null;
      }
    } catch (e) {
      message = e.toString();
      print("error in getDetails $message");
      return null;
    }
  }
}
