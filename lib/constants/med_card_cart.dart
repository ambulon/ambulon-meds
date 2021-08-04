// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/models/cart.model.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/constants/loader.dart';
import 'package:medcomp/constants/toast.dart';
import 'package:medcomp/constants/update.input.dart';

class MedCardCart extends StatelessWidget {
  final Items item;
  // final String name;
  // final String imgUrl;
  final double price;
  // final int quantity;
  // final String id;

  MedCardCart({
    this.item,
    // this.name = 'Name',
    // this.imgUrl = '',
    this.price = 0.0,
    // this.quantity = 1,
    // @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: kElevationToShadow[2],
        borderRadius: BorderRadius.circular(8),
      ),
      height: ScreenUtil().setHeight(110),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              // child: CachedNetworkImage(
              //   height: ScreenUtil().setHeight(110),
              //   imageUrl: imgUrl,
              //   fit: BoxFit.cover,
              // ),
              child: Container(
                height: ScreenUtil().setHeight(110),
                color: Colors.amberAccent,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(12),
                vertical: ScreenUtil().setHeight(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setHeight(17),
                              color: Colors.teal[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Text(
                          '\₹ ${price.toStringAsFixed(1)} per Each',
                          style: TextStyle(
                            fontSize: ScreenUtil().setHeight(13),
                            color: Colors.teal[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Quantity : ${item.quantity}",
                            style: TextStyle(
                              fontSize: ScreenUtil().setHeight(12),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      removeButton(context),
                      SizedBox(width: ScreenUtil().setWidth(12)),
                      updateQuantity(context),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector removeButton(context) {
    return GestureDetector(
      onTap: () async {
        Loader.showLoaderDialog(context);
        CartRepo cartRepo = new CartRepo();
        bool res = await cartRepo.removeItem(item.id);
        Navigator.pop(context);
        if (res) {
          ToastPreset.successful(context: context, str: 'Removed ${item.name}');
          BlocProvider.of<CartBloc>(context).add(CartEventLoad());
        } else {
          ToastPreset.err(context: context, str: 'Something went wrong');
        }
      },
      child: Container(
        child: Center(
          child: Row(
            children: [
              Icon(
                Icons.clear,
                color: Colors.red[300],
                size: ScreenUtil().setHeight(15),
              ),
              SizedBox(width: ScreenUtil().setWidth(4)),
              Text(
                'Remove',
                style: TextStyle(
                  color: Colors.red[300],
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setHeight(13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector updateQuantity(context) {
    return GestureDetector(
      onTap: () {
        showCupertinoDialog(
            context: context,
            builder: (_) => UpdateInput(
                  item: item,
                ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12), vertical: ScreenUtil().setHeight(7)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorTheme.primaryColor,
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: ScreenUtil().setHeight(16),
              ),
              SizedBox(width: ScreenUtil().setWidth(4)),
              Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setHeight(13),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(4)),
            ],
          ),
        ),
      ),
    );
  }
}
