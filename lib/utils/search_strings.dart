import 'package:shared_preferences/shared_preferences.dart';

class SearchStrings {
  static const int limit = 3;
  static List staticPreferredlist = [
    'Paracetamol',
    'Crocin',
    'Zip Mox',
    'Nici Plus',
    'RCinex',
  ];

  // static List historyList = [];

  // static readHistoryList() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     SearchStrings.historyList = prefs.getStringList('history');
  //     if (SearchStrings.historyList == null) {
  //       SearchStrings.historyList = [];
  //     }
  //   } catch (e) {
  //     print("Error here in readin history list $e");
  //     SearchStrings.historyList = [];
  //   }
  //   print("searchstrin hisotry ${SearchStrings.historyList}");
  // }

  // static addList(str) async {
  //   if (SearchStrings.historyList == null || SearchStrings.historyList == []) {
  //     SearchStrings.historyList.insert(0, str.toString());
  //   } else {
  //     SearchStrings.historyList.add(str.toString());
  //   }
  //   if (SearchStrings.historyList.length >= limit) {
  //     SearchStrings.historyList =
  //         SearchStrings.historyList.sublist(SearchStrings.historyList.length - limit, SearchStrings.historyList.length);
  //   }
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('history', SearchStrings.historyList);
  // }

  // static get mergedist {
  //   // return SearchStrings.historyList;
  //   if (SearchStrings.historyList.length == 0) {
  //     return SearchStrings.staticPreferredlist;
  //   } else {
  //     List temp = SearchStrings.historyList;
  //     return temp.addAll(SearchStrings.staticPreferredlist);
  //   }
  // }
}
