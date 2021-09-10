import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/bloc/coupons.bloc.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/constants/error.dart';
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CouponsBloc>(context).add(CouponsEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: BlocConsumer<CouponsBloc, CouponsState>(
        listener: (BuildContext ctx, CouponsState state) {},
        builder: (BuildContext ctx, CouponsState state) {
          if (state is CouponsStateNotLoaded) {
            return SizedBox();
          }
          if (state is CouponsStateLoading) {
            return Styles.responsiveBuilder(Scaffold(
                backgroundColor: Colors.white,
                appBar: CustomAppBar.def(context: context, title: 'Coupons'),
                body: Center(
                  child: Text('loading'),
                )));
          }
          if (state is CouponsStateError) {
            return Styles.responsiveBuilder(ErrorPage(
              message: state.message,
              gotoLogin: true,
            ));
            // return Text(state.message);
          }
          if (state is CouponsStateLoaded) {
            return Styles.responsiveBuilder(page(state));
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget page(CouponsStateLoaded state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.def(context: context, title: 'Coupons'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(15)),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            brandSelector(AppConfig.all),
                            brandSelector(AppConfig.netmeds),
                            brandSelector(AppConfig.apollo),
                            brandSelector(AppConfig.onemg),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: ScreenUtil().setWidth(20)),
                  // appbarIconButton(Icons.delete_forever, ColorTheme.red, () {}),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(15)),
              for (CouponsModel model in state.result)
                selected == AppConfig.all.toLowerCase()
                    ? promoBox(model)
                    : selected == model.brand.toLowerCase()
                        ? promoBox(model)
                        : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget brandSelector(String brand) {
    return GestureDetector(
      onTap: () => setState(() => selected = brand.toLowerCase()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: brand.toLowerCase() == selected ? ColorTheme.green : Colors.transparent,
        ),
        child: Text(
          brand,
          style: TextStyle(
            color: brand.toLowerCase() == selected ? ColorTheme.fontWhite : ColorTheme.greyDark,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget promoBox(CouponsModel model) {
    TextStyle textStyle = const TextStyle(fontSize: 14);
    TextStyle headStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.grey.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.id, style: headStyle),
              ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: model.id)).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied to clipboard")));
                    });
                  },
                  child: Text('COPY')),
            ],
          ),
          const SizedBox(height: 10),
          Text(model.des, style: textStyle),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
            ],
          ),
        ],
      ),
    );
  }
}
