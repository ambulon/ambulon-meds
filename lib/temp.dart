import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TempParent extends StatefulWidget {
  @override
  _TempParentState createState() => _TempParentState();
}

class _TempParentState extends State<TempParent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search'),
      ),
      body: Center(
        child: TextButton(
          child: Text('open search'),
          onPressed: () {
            showSearch(context: context, delegate: TempSearch());
          },
        ),
      ),
    );
  }
}

class TempSearch extends SearchDelegate<String> {
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

  Future<List<dynamic>> func() async {
    var value = await loadAsset('assets/csv/${query[0].toUpperCase() + query[1].toLowerCase()}.csv');
    List temp2 = [];
    try {
      List<List<dynamic>> _data = CsvToListConverter().convert(value);
      print(_data[0]);
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
          future: func(),
          builder: (ctx, value) {
            if (value.hasData) {
              return ListView.builder(
                itemCount: value.data.length,
                itemBuilder: (_, index) {
                  return Text(value.data[index].toString().split("\n")[0]);
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

  @override
  Widget buildResults(BuildContext context) {
    return results();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return results();
  }
}
