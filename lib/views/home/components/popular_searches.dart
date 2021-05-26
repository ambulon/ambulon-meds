import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/models/search.model.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/search/search_result.dart';
import 'package:medcomp/widget_constants/toast.dart';

class PopularSearches extends StatefulWidget {
  @override
  _PopularSearchesState createState() => _PopularSearchesState();
}

class _PopularSearchesState extends State<PopularSearches> {
  bool isTablet;
  List searches = [
    'Paracetamol',
    'Crocin',
    'Zip Mox',
    'Nici Plus',
    'RCinex',
  ];

  Widget categorySlot(String name) {
    String tempname = name.replaceAll(' ', '\n');
    tempname = tempname.replaceAll('and\n', '& ');
    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              CartRepo cartRepo = new CartRepo();
              MedicineModel medModel1 = new MedicineModel('netmeds.com', 20.0, '');
              MedicineModel medModel2 = new MedicineModel('apollo.com', 25.0, '');
              SingleSearchResultModel model = new SingleSearchResultModel(name, [medModel1, medModel2]);
              print('------------------');
              print(model.toJson());
              bool success = await cartRepo.addItem(model.toJson());
              if (success) {
                ToastPreset.successful(context: context, str: 'Item Added');
              } else {
                ToastPreset.err(context: context, str: 'Error');
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => SearchResult(
              //               str: name,
              //               preset: true,
              //             )));
            },
            child: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              radius: isTablet ? ScreenUtil().setWidth(60) : MediaQuery.of(context).size.width * 0.10,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(7)),
          Text(
            "$tempname",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    isTablet = MediaQuery.of(context).size.width > 730;
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(2)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < searches.length; i++) categorySlot(searches[i]),
          ],
        ),
      ),
    );
  }
}
