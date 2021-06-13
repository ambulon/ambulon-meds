import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  Widget results() {
    // List temp = TopPromoSlider.servicelist;
    // List list = [];

    // if (query.isEmpty) {
    //   list = SearchStrings.staticPreferredlist;
    // } else {
    //   list = SearchStrings.staticPreferredlist.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    //   list.add('Search for \'$query\'');
    // }

    return query != null && query.length > 1
        ? StreamBuilder(
            stream: FirebaseFirestore.instance.collection('all').doc('docID').collection(query.substring(0, 2)).snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // doc[0], doc[1]....
                // snapshot.data.docs[0].
                if (snapshot.data.docs.length == 0) {
                  return Text('no docs');
                }
                QueryDocumentSnapshot qds = snapshot.data.docs[0];
                List vals = qds.get('list');
                // return Text(vals.toString());
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: vals.length,
                  itemBuilder: (context, index) {
                    if (vals[index].contains(query)) {
                      return Text(vals[index]);
                    } else {
                      return SizedBox();
                    }
                  },
                );
              } else {
                return Text('no document');
              }
            },
          )
        : SizedBox();

    // return list.isEmpty
    //     ? Container(
    //         constraints: BoxConstraints.expand(),
    //         child: Center(
    //           child: Text(
    //             'No results found',
    //             style: TextStyle(fontSize: ScreenUtil().setHeight(20)),
    //           ),
    //         ),
    //       )
    //     : Container(
    //         padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
    //         child: ListView.builder(
    //           physics: BouncingScrollPhysics(),
    //           itemCount: list.length,
    //           itemBuilder: (context, index) {
    //             return Container(
    //               alignment: Alignment.centerLeft,
    //               margin: EdgeInsets.symmetric(
    //                 vertical: ScreenUtil().setHeight(10),
    //                 horizontal: ScreenUtil().setWidth(18),
    //               ),
    //               child: GestureDetector(
    //                 onTap: () {
    //                   String temp = list[index];
    //                   if (index == list.length - 1) {
    //                     temp = temp.replaceAll('Search for \'', '');
    //                     temp = temp.substring(0, temp.length - 1);
    //                   }
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (_) => SearchResult(
    //                                 str: temp,
    //                               )));
    //                 },
    //                 child: Text(
    //                   list[index],
    //                   style: TextStyle(
    //                     fontSize: ScreenUtil().setHeight(16),
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       );
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

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('search'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
            SizedBox(height: 15),
            query != null && query.length > 1
                ? Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('all').doc('docID').collection(query.substring(0, 2)).snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // doc[0], doc[1]....
                          // snapshot.data.docs[0].
                          if (snapshot.data.docs.length == 0) {
                            return Text('no docs');
                          }
                          QueryDocumentSnapshot qds = snapshot.data.docs[0];
                          List vals = qds.get('list');
                          // return Text(vals.toString());
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: vals.length,
                            itemBuilder: (context, index) {
                              if (vals[index].contains(query)) {
                                return Text(vals[index]);
                              } else {
                                return SizedBox();
                              }
                            },
                          );
                        } else {
                          return Text('no document');
                        }
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
