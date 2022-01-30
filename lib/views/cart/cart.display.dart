import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/constants/loader.dart';
import 'package:medcomp/constants/toast.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/models/cart.model.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/constants/med_card_cart.dart';
import 'package:medcomp/views/home/components/coupons.dart';
import 'package:medcomp/views/login/webfake.dart' if (dart.library.html) 'package:medcomp/views/login/webreal.dart';
import 'package:url_launcher/url_launcher.dart';

class CartDisplay extends StatefulWidget {
  final CartModel cartModel;
  CartDisplay({this.cartModel});
  @override
  _CartDisplayState createState() => _CartDisplayState();
}

class _CartDisplayState extends State<CartDisplay> {
  String selected = AppConfig.recommended;

  Widget appbarIconButton(IconData icon, color, func) {
    return GestureDetector(
      onTap: func,
      child: CircleAvatar(
        backgroundColor: ColorTheme.grey.withOpacity(0.2),
        child: Icon(
          icon,
          color: color,
          size: ScreenUtil().setHeight(23),
        ),
      ),
    );
  }

  Widget brandSelector(brand) {
    return GestureDetector(
      onTap: () => setState(() => selected = brand),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: brand == selected ? ColorTheme.green : Colors.transparent,
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

  Widget buttons(text, func, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: func,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color.withOpacity(0.3),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> goBack(syncBody) async {
    Loader.showLoaderDialog(context);
    CartRepo cartRepo = new CartRepo();
    await cartRepo.syncCart(syncBody);
    await Future.delayed(new Duration(milliseconds: 400));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);

    var syncBody = widget.cartModel.getSyncBody;
    return WillPopScope(
      onWillPop: () async {
        await goBack(syncBody);
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight),
              Expanded(
                child: SingleChildScrollView(
                  // physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(9)),
                      Row(
                        children: [
                          // appbarIconButton(
                          //   Icons.arrow_back,
                          //   ColorTheme.greyDark,
                          //   () async {
                          //     await goBack(syncBody);
                          //   },
                          // ),
                          // SizedBox(width: ScreenUtil().setWidth(15)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Cart',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorTheme.fontBlack,
                                ),
                              ),
                              Text(
                                'You have ${widget.cartModel.items.length} items in your cart',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: ColorTheme.fontBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Row(
                                  children: [
                                    brandSelector(AppConfig.recommended),
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
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      for (var item in widget.cartModel.items)
                        MedCardCart(
                          item: item,
                          brand: selected == AppConfig.recommended ? widget.cartModel.recBrand : selected,
                          syncBody: syncBody,
                        ),
                      // ! Add here
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Divider(color: ColorTheme.greyDark),
                      Row(
                        children: [
                          Text(
                            'TOTAL',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: ColorTheme.fontBlack,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${AppConfig.rs} ${widget.cartModel.brandToTotalPrice(selected).toStringAsFixed(0)}',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.fontBlack,
                            ),
                          ),
                        ],
                      ),
                      selected == AppConfig.recommended
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Recommended Site : ${widget.cartModel.recBrand}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color: ColorTheme.fontBlack,
                                ),
                              ),
                            )
                          : SizedBox(height: 16),
                      SizedBox(height: ScreenUtil().setHeight(35)),
                      Row(
                        children: [
                          buttons(
                            'Clear cart',
                            () async {
                              await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Confirm?'),
                                  content: Text('Are you sure you want the remove all the items from your cart ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        BlocProvider.of<CartBloc>(context).add(CartEventClearCart());
                                      },
                                      child: Text(
                                        'Yes, Remove it',
                                        style: TextStyle(
                                          color: ColorTheme.red,
                                          fontSize: ScreenUtil().setHeight(14),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: ScreenUtil().setWidth(7)),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Go back',
                                        style: TextStyle(
                                          color: ColorTheme.greyDark,
                                          fontSize: ScreenUtil().setHeight(14),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            ColorTheme.red,
                          ),
                          SizedBox(width: ScreenUtil().setWidth(15)),
                          buttons(
                            'Visit Site',
                            () async {
                              String url;
                              if (selected == AppConfig.recommended) {
                                print(widget.cartModel.recBrand);
                                if (widget.cartModel.recBrand == AppConfig.netmeds)
                                  url = AppConfig.netmedsLink;
                                else if (widget.cartModel.recBrand == AppConfig.apollo)
                                  url = AppConfig.apolloLink;
                                else
                                  url = AppConfig.onemgLink;

                                if (kIsWeb) {
                                  openSite(url);
                                } else {
                                  try {
                                    launch(url);
                                  } catch (e) {
                                    ToastPreset.err(str: 'error $e', context: context);
                                  }
                                }
                                return;
                              }
                              if (selected == AppConfig.netmeds)
                                url = AppConfig.netmedsLink;
                              else if (selected == AppConfig.apollo)
                                url = AppConfig.apolloLink;
                              else
                                url = AppConfig.onemgLink;
                              if (kIsWeb) {
                                openSite(url);
                              } else {
                                try {
                                  launch(url);
                                } catch (e) {
                                  ToastPreset.err(str: 'error $e', context: context);
                                }
                              }
                            },
                            ColorTheme.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(15)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CouponsPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorTheme.blue.withOpacity(0.3),
                          ),
                          child: Text(
                            'View Coupons',
                            style: TextStyle(
                              color: ColorTheme.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(15)),
                    ],
                  ),
                ),
              ),
              // ! from herer
            ],
          ),
        ),
      ),
    );
  }

  // void shareSS() async {
  //   try {
  //     RenderRepaintBoundary boundary = _globalKey[pageController.page.toInt()].currentContext.findRenderObject();
  //     ui.Image image = await boundary.toImage();
  //     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     var pngBytes = byteData.buffer.asUint8List();
  //     Share.file('esys image', 'ss32.png', pngBytes, 'image/png', text: 'My optional text.');
  //   } catch (e) {
  //     print(e);
  //     ToastPreset.err(context: context, str: 'Something went wrong');
  //   }
  // }
}
