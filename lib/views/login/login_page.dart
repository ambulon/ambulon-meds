import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcomp/repositories/auth.repo.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
        backgroundColor: ColorTheme.greyDark,
        body: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Image(
                image: AssetImage('assets/logo.png'),
                height: MediaQuery.of(context).size.width * 0.17,
                width: MediaQuery.of(context).size.width * 0.17,
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Text(
                'AMBULON MEDS',
                style: GoogleFonts.montserrat(
                  fontSize: ScreenUtil().setHeight(40),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'One Place for\nto save on medicines',
                style: GoogleFonts.montserrat(
                  fontSize: ScreenUtil().setHeight(28),
                  fontWeight: FontWeight.w400,
                  color: Colors.white60,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(35)),
              GestureDetector(
                onTap: () => AuthRepo.gsignin(context),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
                  child: Image(
                    image: AssetImage('assets/google.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
