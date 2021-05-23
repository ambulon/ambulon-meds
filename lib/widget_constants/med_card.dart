// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/models/search.model.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/search/search_result.dart';
import 'headline.dart';

class MedicineComparisionList {
  static Widget list({
    @required String str,
    @required List<MedicineModel> medlist,
    bool showTitle = true,
    bool compact = false,
    @required BuildContext context,
  }) {
    int limit = medlist.length;
    if (compact && limit > 4) {
      limit = 4;
    }
    return Column(
      children: [
        showTitle
            ? DefaultWidgets.headline(
                str: str,
                small: false,
                verticalMargin: true,
                showAll: compact,
                showAllFunc: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SearchResult(
                                str: str,
                                preset: true,
                              )));
                },
              )
            : SizedBox(),
        for (int i = 0; i < limit; i++)
          MedCard(
            name: str,
            price: medlist[i].price,
            site: medlist[i].site,
            description: medlist[i].des,
          ),
      ],
    );
  }
}

class MedCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final double price;
  final String description;
  final int stars;
  final String site;
  // final bool isZsafe;
  MedCard({
    this.name = 'Paracetamol',
    this.imgUrl = '',
    this.price = 0.0,
    this.description = 'quantity and stuff',
    this.stars = 4,
    this.site = 'alibaba.com',
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
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
                            '$name',
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
                          'Rs. ${price.toStringAsFixed(1)}',
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
                  Container(
                    child: Text(
                      '$description',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setHeight(12),
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  siteAndStars(),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget siteAndStars() {
    String tempSite = site.replaceAll('www.', '');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.insert_link_rounded,
          color: Colors.teal[900],
          size: ScreenUtil().setHeight(15),
        ),
        SizedBox(width: ScreenUtil().setWidth(3)),
        Expanded(
          child: Container(
            child: Text(
              tempSite,
              style: TextStyle(
                fontSize: ScreenUtil().setHeight(12),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(7)),
        starsWidget(),
      ],
    );
  }

  Widget starsWidget() {
    // if (stars == 0) {
    // return SizedBox();
    // } else {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (int i = 1; i <= stars; i++)
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: ScreenUtil().setHeight(12),
            ),
          for (int i = stars + 1; i <= 5; i++)
            Icon(
              Icons.star_border,
              color: Colors.black,
              size: ScreenUtil().setHeight(12),
            ),
        ],
      ),
    );
    // }
  }
}
