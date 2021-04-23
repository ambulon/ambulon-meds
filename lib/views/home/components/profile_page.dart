import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:medcomp/views/login/login_page.dart';
import 'package:medcomp/widget_constants/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final name;
  final email;
  final photo;
  ProfilePage({@required this.name, @required this.email, @required this.photo});

  Widget defaultHeadline(str, bool small) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(
        // vertical: ScreenUtil().setHeight(10),
        horizontal: ScreenUtil().setWidth(18),
      ),
      child: Text(
        str,
        style: TextStyle(
          fontSize: ScreenUtil().setHeight(small ? 16 : 18),
          color: Colors.black,
          fontWeight: small ? FontWeight.w600 : FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().setHeight(20)),
          Container(
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      defaultHeadline(name, true),
                      defaultHeadline(email, false),
                    ],
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: ScreenUtil().setHeight(30),
                  backgroundImage: NetworkImage(photo),
                ),
                SizedBox(width: ScreenUtil().setWidth(18)),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(40)),
          defaultHeadline('Terms and Conditions', true),
          SizedBox(height: ScreenUtil().setHeight(15)),
          defaultHeadline('Report a bug', true),
          SizedBox(height: ScreenUtil().setHeight(15)),
          defaultHeadline('Feedback', true),
          SizedBox(height: ScreenUtil().setHeight(15)),
          GestureDetector(
            onTap: () async {
              try {
                var res = await MyHttp.post('/logout', {});
                if (res.statusCode == 200) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                } else {
                  print("logout error ${res.statusCode} ${res.body}");
                  ToastPreset.err(context: context, str: 'Logout error ${res.statusCode}');
                }
              } catch (e) {
                print("logg out error : $e");
                ToastPreset.err(context: context, str: e);
              }
            },
            child: defaultHeadline('Log out', true),
          ),
          SizedBox(height: ScreenUtil().setHeight(40)),
          // log out
          // terms and condition
          // report a bug
          // feedback
        ],
      ),
    );
  }
}
