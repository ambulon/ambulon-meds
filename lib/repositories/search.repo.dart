import 'dart:async';
import 'dart:convert';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/models/search.model.dart';
import 'package:medcomp/models/searchhistory.model.dart';
import 'package:medcomp/repositories/home.repo.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  String message;

  saveToPrefs(MedicineModel currentModel) async {
    HomeRepo homeRepo = new HomeRepo();
    List<SearchHistoryModel> data = await homeRepo.searchHistory();
    List jsonList = [];
    if (data.length > 0 && data[0].id == currentModel.id) {
      return;
    }
    for (var model in data) {
      jsonList.add(model.toJson());
    }
    jsonList.insert(0, currentModel.toSearchHistoryMap());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (jsonList.length > 6) {
      var jsonString = jsonEncode(jsonList.sublist(0, 6));
      prefs.setString(AppConfig.prefsSearchHistory, jsonString);
    } else {
      var jsonString = jsonEncode(jsonList);
      prefs.setString(AppConfig.prefsSearchHistory, jsonString);
    }
  }

  Future<SearchModel> getDetails(strList, dataList) async {
    try {
      var temp = strList.last.toString().replaceAll('/', '%18');
      // var temp = strList.last;
      var res = await MyHttp.get("user/get-price/$temp");

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        MedicineModel model = new MedicineModel.fromJson(resBody['med']);
        await saveToPrefs(model);
        if (model.apollo == -1 && model.onemg == -1 && model.netmeds == -1) {
          throw ("No record found for the medicine");
        }
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
