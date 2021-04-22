import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchStrings {
  static const list = [
    'Paracetamol',
    'Crocin',
    'Zip Mox',
    'Nici Plus',
    'RCinex',
  ];
}

class MedicineSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            FocusScope.of(context).unfocus();
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  Widget results() {
    // List temp = TopPromoSlider.servicelist;
    List list = [];

    if (query.isEmpty) {
      list = SearchStrings.list;
    } else {
      list = SearchStrings.list.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
      list.add('Search for \'$query\'');
    }

    return list.isEmpty
        ? Container(
            constraints: BoxConstraints.expand(),
            child: Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: ScreenUtil().setHeight(20)),
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(10),
                    horizontal: ScreenUtil().setWidth(18),
                  ),
                  child: Text(
                    list[index],
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(16),
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          );
  }

  @override
  Widget buildResults(BuildContext context) {
    return results();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return results();
  }
}
