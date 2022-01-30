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
  List<String> brand = [
    AppConfig.all,
    AppConfig.netmeds,
    AppConfig.apollo,
    AppConfig.onemg,
  ];

  List<Widget> tabtitle = [
    Text(AppConfig.all),
    Text(AppConfig.netmeds),
    Text(AppConfig.apollo),
    Text(AppConfig.onemg),
  ];

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
    return BlocConsumer<CouponsBloc, CouponsState>(
      listener: (BuildContext ctx, CouponsState state) {},
      builder: (BuildContext ctx, CouponsState state) {
        if (state is CouponsStateNotLoaded) {
          return SizedBox();
        }
        if (state is CouponsStateLoading) {
          return Loader.def();
          // return Loader.gifLoader(context);
        }
        if (state is CouponsStateError) {
          return ErrorPage(
            message: state.message,
            gotoLogin: true,
          );
        }
        if (state is CouponsStateLoaded) {
          return page(state);
        }
        return SizedBox();
      },
    );
  }

  Widget page(CouponsStateLoaded state) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar.defForCoupons(
            context: context,
            title: 'Coupons',
            tablist: tabtitle,
          ),
          body: TabBarView(
            children: [
              for (int i = 0; i < 4; i++) buildpage(state, i),
            ],
          )),
    );
  }

  Widget buildpage(CouponsStateLoaded state, int i) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(15)),
            for (CouponsModel model in state.result)
              brand[i].toLowerCase() == AppConfig.all.toLowerCase()
                  ? promoBox(model)
                  : brand[i].toLowerCase() == model.brand.toLowerCase()
                      ? promoBox(model)
                      : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget promoBox(CouponsModel model) {
    TextStyle textStyle = const TextStyle(fontSize: 14);
    TextStyle headStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.grey.shade300,
      elevation: 5,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(model.imageUrl),
                    ),
                  ),
                ),
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
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
                          Clipboard.setData(new ClipboardData(text: model.id)).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied to clipboard")));
                          });
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.resolveWith<double>((_) {
                            return 2;
                          }),
                          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                            return RoundedRectangleBorder(borderRadius: BorderRadius.circular(19));
                          }),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>((_) {
                            return Colors.indigo.shade900;
                          }),
                        ),
                        child: Text('COPY')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
