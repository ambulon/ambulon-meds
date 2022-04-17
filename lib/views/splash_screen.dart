import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/main.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login/login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startup();
    });
  }

  Future<bool> shouldUpdate() async {
    try {
      QuerySnapshot s = await FirebaseFirestore.instance.collection('config').get();
      String temp = await s.docs.first.get('version');
      print(temp);
      if (temp == Version.code)
        return false;
      else
        return true;
    } catch (e) {
      return false;
    }
    // var res = await MyHttp.get('/force-update');
    // if (res.statusCode == 200) {
    //   var body = jsonDecode(res.body);
    //   if (Version.code != body['version']) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
    //   return false;
    // }
  }

  startup() async {
    if (!kIsWeb) {
      if (await shouldUpdate()) {
        showCupertinoModalPopup(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            content: Text(
              'A new update is available on the Play Store, Update the app to enjoy less bugged app with minor fixes.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String url = "https://play.google.com/store/apps/details?id=com.ambulon.meds";
                  if (await canLaunch(url)) {
                    launch(url);
                  }
                },
                child: Text('UPDATE'),
              ),
            ],
          ),
        );
        return;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Dashboard()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: Styles.getWidth(context),
      height: Styles.getHeight(context),
      allowFontScaling: true,
    )..init(context);

    return Scaffold();
  }
}
