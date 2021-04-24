import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcomp/bloc/search.bloc.dart';
import 'package:medcomp/events/search.event.dart';
import 'package:medcomp/states/search.state.dart';
import 'package:medcomp/widget_constants/custom_appbar.dart';
import 'package:medcomp/widget_constants/error.dart';
import 'package:medcomp/widget_constants/headline.dart';
import 'package:medcomp/widget_constants/loader.dart';
import 'package:medcomp/widget_constants/toast.dart';

import 'components/search_field.dart';

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
            return Scaffold(
              appBar: CustomAppBar.defForSearchResult(
                title: 'Search',
                context: context,
                backFunc: () {
                  List temp = state.searchModel.strList;
                  if (temp.length == 1) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    BlocProvider.of<SearchBloc>(context).add(SearchEventRemoveSearch());
                  }
                },
                searchFunc: () {
                  showSearch(
                    context: context,
                    delegate: SearchResultBar(
                      func: (newStr) {
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
                    ),
                    query: state.searchModel.strList.last,
                  );
                },
              ),
              body: Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      DefaultWidgets.headline(
                        str: "Search results for ${state.searchModel.strList.last}",
                        small: true,
                        verticalMargin: true,
                      ),
                      for (int i = 0; i < state.searchModel.strList.length; i++)
                        Text("${state.searchModel.strList[i]} : ${state.searchModel.dataList[i].details}"),
                    ],
                  ),
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
