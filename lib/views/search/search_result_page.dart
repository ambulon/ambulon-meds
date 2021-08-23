import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/bloc/search.bloc.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/events/search.event.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/states/search.state.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/constants/search.delegate.dart';
import 'package:medcomp/constants/error.dart';
import 'package:medcomp/constants/loader.dart';
import 'package:medcomp/constants/toast.dart';

class SearchResult extends StatefulWidget {
  final str;
  final bool preset;
  SearchResult({@required this.str, this.preset = false});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String newStr;
  String selected = AppConfig.all;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(SearchEventLoadData(strList: [widget.str], dataList: []));
  }

  Widget appbarIconButton(IconData icon, func) {
    return GestureDetector(
      onTap: func,
      child: CircleAvatar(
        backgroundColor: ColorTheme.grey.withOpacity(0.2),
        child: Icon(
          icon,
          color: ColorTheme.fontWhite,
          size: 25,
        ),
      ),
    );
  }

  Widget brandSelector(brand, price) {
    if (brand != AppConfig.all && price == -1) {
      return SizedBox();
    }
    return GestureDetector(
      onTap: () => setState(() => selected = brand),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: brand == selected ? ColorTheme.green : Colors.white,
        ),
        child: Text(
          brand,
          style: TextStyle(
            color: brand == selected ? ColorTheme.fontWhite : ColorTheme.greyDark,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget allBrandPriceBox(String brand, double price) {
    if (price == -1) {
      return SizedBox();
    }
    return Container(
      child: Column(
        children: [
          Text(
            '${AppConfig.rs} ${price.toStringAsFixed(0)}',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorTheme.fontBlack,
            ),
          ),
          SizedBox(height: 2),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: ColorTheme.blue,
            ),
            child: Text(
              brand,
              style: TextStyle(
                color: ColorTheme.fontWhite,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttons(text, func) {
    return Expanded(
      child: GestureDetector(
        onTap: func,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ColorTheme.blue.withOpacity(0.3),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: ColorTheme.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);
    return Styles.responsiveBuilder(page());
  }

  Widget page() {
    return WillPopScope(
      onWillPop: () {
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
            BlocProvider.of<HomeBloc>(context).add(HomeEventRefreshSearches());
            return ErrorPage(
              message: state.message,
              popFunction: () {
                Navigator.pop(context);
              },
            );
          }
          if (state is SearchStateLoaded) {
            MedicineModel data = state.searchModel.dataList.last;
            return Scaffold(
              backgroundColor: ColorTheme.fontWhite,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    actions: [
                      SizedBox(width: 15),
                      appbarIconButton(Icons.arrow_back, () {
                        if (widget.preset) {
                          BlocProvider.of<HomeBloc>(context).add(HomeEventRefreshSearches());
                          Navigator.pop(context);
                        } else {
                          List temp = state.searchModel.strList;
                          if (temp.length == 1) {
                            BlocProvider.of<HomeBloc>(context).add(HomeEventRefreshSearches());
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            BlocProvider.of<SearchBloc>(context).add(SearchEventRemoveSearch());
                          }
                        }
                      }),
                      Spacer(),
                      widget.preset
                          ? SizedBox()
                          : appbarIconButton(Icons.search, () {
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
                                query: "",
                                // query: state.searchModel.strList.last,
                              );
                            }),
                      SizedBox(width: 15),
                    ],
                    backgroundColor: ColorTheme.greyDark,
                    pinned: true,
                    expandedHeight: ScreenUtil().setHeight(400),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(data.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: ColorTheme.fontWhite,
                            borderRadius:
                                BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                          ),
                          child: Column(
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Row(
                                  children: [
                                    brandSelector(AppConfig.all, 0),
                                    brandSelector(AppConfig.netmeds, data.netmeds),
                                    brandSelector(AppConfig.apollo, data.apollo),
                                    brandSelector(AppConfig.onemg, data.onemg),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 25),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.medical_services_outlined,
                                      color: ColorTheme.greyDark,
                                      size: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          selected == AppConfig.all
                                              ? 'Best from : ${data.bestBuySite}'
                                              : '${data.name}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            // fontWeight: FontWeight.bold,
                                            color: ColorTheme.greyDark,
                                          ),
                                        ),
                                        Text(
                                          selected == AppConfig.all ? '${data.name}' : '${data.brandToPrice(selected)}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: ColorTheme.fontBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    data.bestBuySite == selected
                                        ? Container(
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(17),
                                              color: Colors.yellow,
                                            ),
                                            child: Text(
                                              'BEST BUY',
                                              style: TextStyle(
                                                color: ColorTheme.fontBlack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                              selected != AppConfig.all
                                  ? Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: ColorTheme.green,
                                      ),
                                      child: Text(
                                        'BUY FROM SITE',
                                        style: TextStyle(
                                          color: ColorTheme.fontWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        allBrandPriceBox(AppConfig.netmeds, data.netmeds),
                                        allBrandPriceBox(AppConfig.apollo, data.apollo),
                                        allBrandPriceBox(AppConfig.onemg, data.onemg),
                                      ],
                                    ),
                              SizedBox(height: 25),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Product Description',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorTheme.fontBlack,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  data.des,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: ColorTheme.greyDark,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Spacer(),
                                  // buttons('REPORT AN ERROR', () {}),
                                  // SizedBox(width: 20),
                                  buttons('ADD TO CART', () async {
                                    Loader.showLoaderDialog(context);
                                    CartRepo cartRepo = new CartRepo();
                                    bool res = await cartRepo.addItem(data.toJson());
                                    Navigator.pop(context);
                                    if (res) {
                                      ToastPreset.successful(context: context, str: 'Added to cart');
                                    } else {
                                      ToastPreset.err(context: context, str: 'Something went wrong');
                                    }
                                  }),
                                ],
                              ),
                              SizedBox(height: 30),
                              // Container(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     'More Products',
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.bold,
                              //       color: ColorTheme.fontBlack,
                              //     ),
                              //   ),
                              // ),
                              // ProductsGrid(['', '', '']),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
