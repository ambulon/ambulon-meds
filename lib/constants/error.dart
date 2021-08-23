import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/login/login_page.dart';

class ErrorPage extends StatelessWidget {
  final message;
  final retryFunction;
  final popFunction;
  final bool gotoLogin;

  ErrorPage({
    @required this.message,
    this.retryFunction,
    this.popFunction,
    this.gotoLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(flex: 3, child: SizedBox()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              width: double.infinity,
              child: Image(
                image: AssetImage('assets/error.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Text(
              'Oops Error!!!',
              style: GoogleFonts.montserrat(
                color: ColorTheme.greyDark,
                fontSize: ScreenUtil().setHeight(30),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              alignment: Alignment.center,
              child: Text(
                "$message",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorTheme.greyDark,
                  fontSize: ScreenUtil().setHeight(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            gotoLogin
                ? Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 25,
                          color: Color(0xFF59618B).withOpacity(0.37),
                        ),
                      ],
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      color: Color(0xFF6371AA),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Text(
                        "LOGIN AGAIN".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      popFunction != null
                          ? Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 25,
                                    color: ColorTheme.red.withOpacity(0.37),
                                  ),
                                ],
                              ),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                color: ColorTheme.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                onPressed: popFunction,
                                child: Text(
                                  "GO BACK".toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(width: ScreenUtil().setWidth(20)),
                      retryFunction != null
                          ? Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 25,
                                    color: Color(0xFF59618B).withOpacity(0.37),
                                  ),
                                ],
                              ),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                color: Color(0xFF6371AA),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                onPressed: retryFunction,
                                child: Text(
                                  "RETRY".toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
            Expanded(flex: 6, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
