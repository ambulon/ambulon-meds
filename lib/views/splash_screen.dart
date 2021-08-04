import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/views/login/login_page.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startup();
  }

  startup() async {
    await Future.delayed(new Duration(milliseconds: 1000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != null) {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => Home()));
    } else {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    return Scaffold(
      backgroundColor: ColorTheme.fontWhite,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: ColorTheme.fontWhite,
        ),
        child: Column(
          children: [
            Expanded(flex: 3, child: SizedBox()),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorTheme.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image(
                height: ScreenUtil().setHeight(100),
                width: ScreenUtil().setHeight(100),
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'AMBULON',
              style: GoogleFonts.montserrat(
                fontSize: ScreenUtil().setHeight(25),
                color: ColorTheme.greyDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(flex: 6, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
