import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    await Future.delayed(new Duration(milliseconds: 100));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }

  // startup() async {
  //   await Future.delayed(new Duration(milliseconds: 100));
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var isFirstTime = prefs.getBool('first_time');
  //   if (isFirstTime != null && !isFirstTime) {
  //     prefs.setBool('first_time', false);
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
  //   } else {
  //     prefs.setBool('first_time', false);
  //     String token = prefs.getString('token');

  //     if (token == null) {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
  //     } else {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: ScreenUtil().setWidth(60),
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
