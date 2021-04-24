import 'dart:async';
// import 'dart:convert';
import 'package:medcomp/models/search.model.dart';
// import 'package:medcomp/utils/my_url.dart';
// import 'dart:developer';

class SearchRepo {
  String message;

  Future<SearchModel> getDetails(strList, dataList) async {
    await Future.delayed(new Duration(milliseconds: 500));
    SearchModel result = SearchModel.fromJson({}, strList, dataList);
    // await SearchStrings.addList(strList.last);
    return result;
    // try {
    //   var res = await MyHttp.get("user/get-details/${strList.last}");

    //   if (res.statusCode == 200) {
    //     var resBody = jsonDecode(res.body);
    //     print("user/get-details : $resBody");
    //     SearchModel result = SearchModel.fromJson(resBody, strList, []);

    //     inspect(result);
    //     return result;
    //   } else {
    //     print("Error code for search repo is ${res.statusCode} ${res.body}");
    //     message = "Error code for search repo is ${res.statusCode} ${res.body}";
    //     return null;
    //   }
    // } catch (e) {
    //   message = e.toString();
    //   print("error in getDetails $message");
    //   return null;
    // }
  }
}
