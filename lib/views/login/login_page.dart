import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcomp/constants/web.view.dart';
import 'package:medcomp/repositories/auth.repo.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'webfake.dart' if (dart.library.html) 'webreal.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Styles.responsiveBuilder(page()),
    );
  }

  Widget page() {
    return Scaffold(
      backgroundColor: ColorTheme.greyDark,
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Image(
              image: AssetImage('assets/app-logo.png'),
              height: Styles.wForLaptop * 0.25,
              width: Styles.wForLaptop * 0.25,
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
            Container(
              child: Row(
                children: [
                  Text(
                    'By continuing, you agree to our ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(13),
                      color: ColorTheme.fontWhite,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (kIsWeb) {
                        // html.window.open('https://ambulon-1.flycricket.io/privacy.html', 'new tab');
                        openSite('https://ambulon-1.flycricket.io/privacy.html');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewPage(link: 'https://ambulon-1.flycricket.io/privacy.html'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: ScreenUtil().setHeight(13),
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.fontWhite,
                      ),
                    ),
                  ),
                  Text(
                    ' and ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(13),
                      color: ColorTheme.fontWhite,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (kIsWeb) {
                  openSite('https://ambulon.flycricket.io/privacy.html');
                  // html.window.open('https://ambulon.flycricket.io/privacy.html', 'new tab');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WebViewPage(link: 'https://ambulon.flycricket.io/privacy.html'),
                    ),
                  );
                }
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: ScreenUtil().setHeight(13),
                  fontWeight: FontWeight.bold,
                  color: ColorTheme.fontWhite,
                ),
              ),
            ),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: 'Terms & Conditions',
            //         recognizer: new TapGestureRecognizer()..onTap = () {},
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       TextSpan(text: ' and '),
            //       TextSpan(
            //         text: 'Privacy Policy',
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // )),
            SizedBox(height: ScreenUtil().setHeight(25)),
          ],
        ),
      ),
    );
  }
}
