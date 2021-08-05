import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/models/cartitem.model.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/constants/loader.dart';
import 'package:medcomp/constants/toast.dart';

class MedCardCart extends StatelessWidget {
  final Item item;
  final String brand;
  final syncBody;
  final h = 110;
  MedCardCart({this.item, this.brand, @required this.syncBody});
  final int limit = 5;

  double brandToPrice() {
    switch (brand) {
      case AppConfig.netmeds:
        return item.price.netmeds;
        break;
      case AppConfig.apollo:
        return item.price.apollo;
        break;
      case AppConfig.onemg:
        return item.price.i1mg;
        break;
      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(10),
      ),
      height: ScreenUtil().setHeight(h),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              await removeConfirm(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.cancel,
                color: ColorTheme.red,
                size: ScreenUtil().setHeight(25),
              ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(2)),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: ScreenUtil().setWidth(15)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                        width: ScreenUtil().setHeight(h - 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(item.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppConfig.rs} ${brandToPrice()} each',
                            style: TextStyle(
                              color: ColorTheme.fontBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setHeight(16),
                            ),
                          ),
                          Text(
                            '${item.name}',
                            style: TextStyle(
                              color: ColorTheme.fontBlack,
                              fontSize: ScreenUtil().setHeight(14),
                            ),
                          ),
                          Text(
                            '@ ${AppConfig.rs}${(brandToPrice() * item.quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              color: ColorTheme.fontBlack,
                              fontSize: ScreenUtil().setHeight(14),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: InkWell(
                                onTap: () async {
                                  if (item.quantity >= limit) {
                                    ToastPreset.err(context: context, str: 'You cannot add more than $limit items');
                                  } else {
                                    Loader.showLoaderDialog(context);
                                    Item updatedItem = item;
                                    updatedItem.quantity = item.quantity + 1;
                                    BlocProvider.of<CartBloc>(context).add(CartEventUpdateQuantity(updatedItem));
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  width: ScreenUtil().setWidth(40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                                    color: item.quantity >= limit ? ColorTheme.grey : ColorTheme.blue.withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: ScreenUtil().setWidth(20),
                                    color: item.quantity >= limit ? ColorTheme.greyDark : ColorTheme.blue,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                width: ScreenUtil().setWidth(40),
                                color: ColorTheme.fontWhite,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: ColorTheme.fontBlack,
                                      size: ScreenUtil().setHeight(12),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: TextStyle(
                                        color: ColorTheme.fontBlack,
                                        fontSize: ScreenUtil().setHeight(17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: InkWell(
                                onTap: () async {
                                  if (item.quantity == 1) {
                                    await removeConfirm(context);
                                  } else {
                                    Loader.showLoaderDialog(context);
                                    Item updatedItem = item;
                                    updatedItem.quantity = item.quantity - 1;
                                    BlocProvider.of<CartBloc>(context).add(CartEventUpdateQuantity(updatedItem));
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  width: ScreenUtil().setWidth(40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                                    color: ColorTheme.red.withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: ScreenUtil().setWidth(20),
                                    color: ColorTheme.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                brandToPrice() == -1
                    ? GestureDetector(
                        onTap: () {
                          print("nothing");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorTheme.greyDark.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> removeConfirm(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirm?'),
        content: Text('Are you sure you want the remove the item ${item.name} from your cart ?'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              Loader.showLoaderDialog(context);
              CartRepo cartRepo = new CartRepo();
              bool resSync = await cartRepo.syncCart(syncBody);
              if (resSync == null || !resSync) {
                ToastPreset.err(context: context, str: 'Error while syncing cart');
                return;
              }
              await Future.delayed(new Duration(milliseconds: 400));
              bool resRemove = await cartRepo.removeItem(item.id);
              Navigator.pop(context);
              if (resRemove) {
                ToastPreset.successful(context: context, str: 'Removed ${item.name}');
                BlocProvider.of<CartBloc>(context).add(CartEventLoad());
              } else {
                ToastPreset.err(context: context, str: 'Something went wrong');
              }
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
  }
}
