// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/bloc/coupons.bloc.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/constants/error.dart';
import 'package:medcomp/constants/loader.dart';
import 'package:medcomp/events/coupons.event.dart';
import 'package:medcomp/models/coupons.model.dart';
import 'package:medcomp/states/coupons.state.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';

class CouponsPage extends StatefulWidget {
  @override
  _CouponsPageState createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  String selected = AppConfig.all.toLowerCase();
  //int current_ind = 0;

  List<String> brand = [
    AppConfig.all,
    AppConfig.netmeds,
    AppConfig.apollo,
    AppConfig.onemg
  ];

  changeselected(int current_ind) {
    setState(() {
      selected = brand[current_ind].toLowerCase();
      print(current_ind);
      print(selected);
    });
  }

  List<CouponsModel> result = [
    CouponsModel("1", "abc", AppConfig.netmeds),
    CouponsModel("2", "mno", AppConfig.apollo),
    CouponsModel("3", "xyz", AppConfig.onemg),
  ];

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<CouponsBloc>(context).add(CouponsEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: Styles.getWidth(context),
        height: Styles.getHeight(context),
        allowFontScaling: true)
      ..init(context);
    return page();
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: BlocConsumer<CouponsBloc, CouponsState>(
        listener: (BuildContext ctx, CouponsState state) {},
        builder: (BuildContext ctx, CouponsState state) {
          if (state is CouponsStateNotLoaded) {
            return SizedBox();
          }
          if (state is CouponsStateLoading) {
            return Loader.gifLoader(context);
          }
          if (state is CouponsStateError) {
            return Styles.responsiveBuilder(ErrorPage(
              message: state.message,
              gotoLogin: true,
            ));
            // return Text(state.message);
          }
          if (state is CouponsStateLoaded) {
            // return Styles.responsiveBuilder(page(state));
            return Styles.responsiveBuilder(page());
          }
          return SizedBox();
        },
      ),
    );
  }

  // Widget page(CouponsStateLoaded state) {
  Widget page() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: CustomAppBar.defForCoupons(
          //   context: context,
          //   title: 'Coupons',
          //   tablist: tabtitle,
          //   changeselected: changeselected,
          // ),
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: ScreenUtil().setHeight(18),
                color: Colors.white,
              ),
            ),
            backgroundColor: ColorTheme.greyDark,
            centerTitle: true,
            title: Text(
              'Coupons',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            bottom: TabBar(
              padding: EdgeInsets.symmetric(horizontal: 20),
              labelPadding: EdgeInsets.all(6),
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              tabs: tabtitle,
              labelStyle: TextStyle(fontSize: 17),
              onTap: (value) {
                changeselected(value);
                print("$value info");
              },
            ),
          ),
          body: TabBarView(
            children: [
              // buildpage(state),
              // buildpage(state),
              // buildpage(state),
              // buildpage(state)
              buildpage(),
              buildpage(),
              buildpage(),
              buildpage()
            ],
          )),
    );
  }

  // Widget buildpage(CouponsStateLoaded state) {
  Widget buildpage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //SizedBox(height: ScreenUtil().setHeight(15)),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         child: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           physics: BouncingScrollPhysics(),
            //           child: Row(
            //             children: [
            //               brandSelector(AppConfig.all),
            //               brandSelector(AppConfig.netmeds),
            //               brandSelector(AppConfig.apollo),
            //               brandSelector(AppConfig.onemg),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     // SizedBox(width: ScreenUtil().setWidth(20)),
            //     // appbarIconButton(Icons.delete_forever, ColorTheme.red, () {}),
            //   ],
            // ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            //for (CouponsModel model in state.result)
            for (CouponsModel model in result)
              selected == AppConfig.all.toLowerCase()
                  ? promoBox(model)
                  : selected == model.brand.toLowerCase()
                      ? promoBox(model)
                      : SizedBox(),
          ],
        ),
      ),
    );
  }

  List<Widget> tabtitle = [
    Text(AppConfig.all),
    Text(AppConfig.netmeds),
    Text(AppConfig.apollo),
    Text(AppConfig.onemg)
  ];

  // Widget brandSelector(String brand) {
  //   return GestureDetector(
  //     onTap: () => setState(() => selected = brand.toLowerCase()),
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(17),
  //         color: brand.toLowerCase() == selected
  //             ? ColorTheme.green
  //             : Colors.transparent,
  //       ),
  //       child: Text(
  //         brand,
  //         style: TextStyle(
  //           color: brand.toLowerCase() == selected
  //               ? ColorTheme.fontWhite
  //               : ColorTheme.greyDark,
  //           fontSize: 13,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Map<String, String> couponicon = {
    AppConfig.onemg: "assets/onemg.png",
    AppConfig.netmeds: "assets/netmeds.jpg",
    AppConfig.apollo: "assets/apollo.jpg"
  };

  Widget promoBox(CouponsModel model) {
    TextStyle textStyle = const TextStyle(fontSize: 14);
    TextStyle headStyle =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Card(
      //width: double.infinity,
      //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.grey.shade300,
      elevation: 5,
      shadowColor: Colors.black,
      // decoration:BoxDecoration(
      //
      //   borderRadius: BorderRadius.circular(5),
      //   //boxShadow: BoxShadow()
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(couponicon[model.brand])))),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(model.id, style: headStyle),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: ColorTheme.green,
                  ),
                  child: Text(
                    model.brand,
                    style: TextStyle(
                      color: ColorTheme.fontWhite,
                      fontSize: 13,
                    ),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Clipboard.setData(new ClipboardData(text: model.id))
                //           .then((_) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //             SnackBar(content: Text("Copied to clipboard")));
                //       });
                //     },
                //     child: Text('COPY')
                // ),
              ],
            ),
            const SizedBox(height: 10),
            Text(model.des, style: textStyle),
            const SizedBox(height: 10),
            Divider(
              color: Colors.grey.shade400,
              thickness: 1,
              indent: 6,
              endIndent: 6,
            ),
            Text("Copy code and use at checkout"),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Container(
                height: 38,
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(19),
                  color: Colors.black.withOpacity(.2),
                ),
                child: Row(
                  children: [
                    Text(model.id),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(new ClipboardData(text: model.id))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Copied to clipboard")));
                          });
                        },
                        style: ButtonStyle(
                          elevation:
                              MaterialStateProperty.resolveWith<double>((_) {
                            return 2;
                          }),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19));
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>((_) {
                            return Colors.indigo.shade900;
                          }),
                        ),
                        child: Text('COPY')),
                  ],
                ),
              ),
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //         onPressed: () {
            //           Clipboard.setData(new ClipboardData(text: model.id))
            //               .then((_) {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //                 SnackBar(content: Text("Copied to clipboard")));
            //           });
            //         },
            //         child: Text('COPY')),
            //     // Container(
            //     //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            //     //   decoration: BoxDecoration(
            //     //     borderRadius: BorderRadius.circular(17),
            //     //     color: ColorTheme.green,
            //     //   ),
            //     //   child: Text(
            //     //     model.brand,
            //     //     style: TextStyle(
            //     //       color: ColorTheme.fontWhite,
            //     //       fontSize: 13,
            //     //     ),
            //     //   ),
            //     // ),
            //   ],
            //),
          ],
        ),
      ),
    );
  }
}
