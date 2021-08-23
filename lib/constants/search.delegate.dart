import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/utils/styles.dart';
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

  Widget results() {
    return query != null && query.length > 1
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(AppConfig.firestoreCollection)
                .doc(AppConfig.firebaseDoc)
                .collection(query[0].toUpperCase() + query[1])
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length == 0) {
                  return Text('no medicine found, Search for $query', style: textStyle);
                }
                QueryDocumentSnapshot qds = snapshot.data.docs[0];
                List vals = qds.get('list');
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: vals.length,
                  itemBuilder: (context, index) {
                    if (vals[index].toString().toLowerCase().contains(query.toLowerCase())) {
                      return GestureDetector(
                        onTap: () {
                          if (customFunc) {
                            Navigator.pop(context);
                            func(vals[index]);
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => SearchResult(str: vals[index])));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(12), vertical: ScreenUtil().setHeight(7)),
                          child: Text(vals[index], style: textStyle),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                );
              } else {
                return SizedBox();
              }
            },
          )
        : SizedBox();
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
