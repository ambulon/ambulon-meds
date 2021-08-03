import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/search.bloc.dart';
import 'package:medcomp/events/search.event.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/states/search.state.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/widget_constants/search.delegate.dart';
import 'package:medcomp/widget_constants/custom_appbar.dart';
import 'package:medcomp/widget_constants/error.dart';
import 'package:medcomp/widget_constants/headline.dart';
import 'package:medcomp/widget_constants/loader.dart';
import 'package:medcomp/widget_constants/med_card.dart';
import 'package:medcomp/widget_constants/toast.dart';

class SearchResult extends StatefulWidget {
  final str;
  final bool preset;
  SearchResult({@required this.str, this.preset = false});

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
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
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
            return Loader.def();
          }
          if (state is SearchStateError) {
            return ErrorPage(
              message: state.message,
            );
          }
          if (state is SearchStateLoaded) {
            MedicineModel data = state.searchModel.dataList.last;
            return Scaffold(
              appBar: CustomAppBar.defForSearchResult(
                showSearchButton: !widget.preset,
                title: 'Search',
                context: context,
                backFunc: () {
                  if (widget.preset) {
                    Navigator.pop(context);
                  } else {
                    List temp = state.searchModel.strList;
                    if (temp.length == 1) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      BlocProvider.of<SearchBloc>(context).add(SearchEventRemoveSearch());
                    }
                  }
                },
                searchFunc: () {
                  showSearch(
                    context: context,
                    delegate: MedicineSearch(
                      customFunc: true,
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
                      DefaultWidgets.cartHeadline(
                        onTap: () async {
                          // ToastPreset.err(context: context, str: 'CAnt add anyting to cart');
                          Loader.showLoaderDialog(context);
                          CartRepo cartRepo = new CartRepo();
                          bool res = await cartRepo.addItem(data.toJson());
                          Navigator.pop(context);
                          if (res) {
                            ToastPreset.successful(context: context, str: 'Added to cart');
                          } else {
                            ToastPreset.err(context: context, str: 'Something went wrong');
                          }
                        },
                      ),
                      MedicineComparisionList.list(
                        model: data,
                        showTitle: false,
                        compact: false,
                        context: context,
                      ),
                      // Text('MedcineCOMPARISIONLIST.LIST fr ${state.searchModel.dataList.last.name}'),
                      // for (int i = 0; i < data.list.length; i++) Text("${data.list[i].site} : ${data.list[i].price}"),
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