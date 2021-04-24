import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/search_strings.dart';

class SearchResultBar extends SearchDelegate<String> {
  final func;
  SearchResultBar({@required this.func});

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
    List list = [];

    if (query.isEmpty) {
      list = SearchStrings.staticPreferredlist;
    } else {
      list = SearchStrings.staticPreferredlist.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      String temp = list[index];
                      if (index == list.length - 1) {
                        temp = temp.replaceAll('Search for \'', '');
                        temp = temp.substring(0, temp.length - 1);
                      }
                      func(temp);
                    },
                    child: Text(
                      list[index],
                      style: TextStyle(
                        fontSize: ScreenUtil().setHeight(16),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
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
