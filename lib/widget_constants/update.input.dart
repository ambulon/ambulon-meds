import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/models/cart.model.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/widget_constants/toast.dart';

class UpdateInput extends StatefulWidget {
  final Items item;
  UpdateInput({@required this.item});
  @override
  _UpdateInputState createState() => _UpdateInputState();
}

class _UpdateInputState extends State<UpdateInput> {
  String amount;
  int limit = 20;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    var clipRRect = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        child: Container(
          padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change Credits to be used',
                  style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setHeight(20), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              SizedBox(height: ScreenUtil().setHeight(5)),
              Row(
                children: [
                  Text('MAX $limit'),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: TextField(
                      onChanged: (val) {
                        amount = val;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15), vertical: ScreenUtil().setHeight(12)),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      try {
                        int temp = int.parse(amount);
                        print("parsed");
                        print(temp);
                        if (temp > limit) {
                          ToastPreset.err(context: context, str: 'Exceeded max value');
                        } else {
                          Items updatedItem = widget.item;
                          updatedItem.quantity = temp;
                          BlocProvider.of<CartBloc>(context).add(CartEventUpdateQuantity(updatedItem));
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        ToastPreset.err(context: context, str: 'wrong input');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12), horizontal: ScreenUtil().setWidth(25)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorTheme.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setHeight(14), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(15)),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12), horizontal: ScreenUtil().setWidth(25)),
                      // width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      child: Center(
                        child: Text(
                          'Back',
                          style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setHeight(14), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    return Column(
      children: <Widget>[
        Spacer(),
        clipRRect,
        Spacer(),
      ],
    );
  }
}
