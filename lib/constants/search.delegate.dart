import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/search/request.dart';
import 'package:medcomp/views/search/search_result_page.dart';

class MedicineSearch extends SearchDelegate<String> {
  final bool customFunc;
  final func;
  MedicineSearch({this.customFunc = false, this.func});

  TextStyle textStyle = new TextStyle(
    fontSize: ScreenUtil().setHeight(16),
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

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

  Future<String> loadAsset(str) async {
    return await rootBundle.loadString(str);
  }

  Future<List<dynamic>> funcOnChange() async {
    var value = await loadAsset('assets/csv/${query[0].toUpperCase() + query[1].toLowerCase()}.csv');
    List temp2 = [];
    try {
      List<List<dynamic>> _data = CsvToListConverter().convert(value);
      // print(_data[0]);
      _data[0].removeAt(0);
      for (var s in _data[0]) {
        if (s.toString().toLowerCase().contains(query.toLowerCase())) {
          temp2.add(s);
        }
      }
    } catch (e) {
      print("error $e");
    }
    return temp2;
  }

  Widget results() {
    if (query != null && query.length > 1) {
      return FutureBuilder(
          future: funcOnChange(),
          builder: (ctx, value) {
            if (value.hasData) {
              if (value.data.length == 0) {
                return requestBox(ctx);
              }
              return ListView.builder(
                itemCount: value.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (customFunc) {
                        Navigator.pop(context);
                        func(value.data[index].toString().split("\n")[0]);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchResult(str: value.data[index].toString().split("\n")[0])));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12), vertical: ScreenUtil().setHeight(7)),
                      child: Text(value.data[index].toString().split("\n")[0], style: textStyle),
                    ),
                  );
                },
              );
            } else {
              return SizedBox();
            }
          });
    } else {
      return SizedBox();
    }
  }

  Column requestBox(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Text('no medicine found with name $query', style: textStyle),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.push(context, MaterialPageRoute(builder: (_) => RequestMedicine(text: query)));
          },
          child: Text('Request for medicine'),
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Styles.responsiveBuilder(results());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Styles.responsiveBuilder(results());
  }
}
