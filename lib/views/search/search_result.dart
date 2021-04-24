import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcomp/bloc/search.bloc.dart';
import 'package:medcomp/events/search.event.dart';
import 'package:medcomp/states/search.state.dart';
import 'package:medcomp/widget_constants/error.dart';
import 'package:medcomp/widget_constants/loader.dart';
import 'package:medcomp/widget_constants/toast.dart';

class SearchResult extends StatefulWidget {
  final str;
  SearchResult({@required this.str});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String newStr;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(SearchEventLoadData(strList: [widget.str], dataList: []));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (BuildContext ctx, SearchState state) {},
        builder: (BuildContext ctx, SearchState state) {
          if (state is SearchStateNotLoaded) {
            return SizedBox();
          }
          if (state is SearchStateLoading) {
            return Loader();
          }
          if (state is SearchStateError) {
            return ErrorPage(
              message: state.message,
            );
          }
          if (state is SearchStateLoaded) {
            // return loadPage(state.userModel);
            // next search -> state.list.add(), event : newList
            // prev search -> state.list.pop() event : newList
            return Scaffold(
              appBar: AppBar(
                title: Text(state.searchModel.strList.last),
              ),
              body: Center(
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        List temp = state.searchModel.strList;
                        if (temp.length == 1) {
                          // send to home
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          BlocProvider.of<SearchBloc>(context).add(SearchEventRemoveSearch());
                          // BlocProvider.of<SearchBloc>(context).add(SearchEventLoadData(strList: temp));
                        }
                      },
                      child: Text('bback'),
                    ),
                    TextField(
                      onChanged: (val) {
                        newStr = val;
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (newStr != null && newStr != "") {
                          List temp = state.searchModel.strList;
                          temp.add(newStr);
                          BlocProvider.of<SearchBloc>(context).add(SearchEventLoadData(
                            strList: temp,
                            dataList: state.searchModel.dataList,
                          ));
                        } else {
                          ToastPreset.err(context: context, str: 'ENTER');
                        }
                      },
                      child: Text('search'),
                    ),
                    for (int i = 0; i < state.searchModel.dataList.length; i++) Text("${state.searchModel.dataList[i].details}"),
                    Divider(),
                    for (int i = 0; i < state.searchModel.strList.length; i++)
                      Text("${state.searchModel.strList[i]} : ${state.searchModel.dataList[i].details}"),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
