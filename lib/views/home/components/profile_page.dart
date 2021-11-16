import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/constants/web.view.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/main.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/home/components/saviour_poster.dart';
import 'package:medcomp/views/login/login_page.dart';
import 'package:medcomp/constants/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medcomp/views/login/webfake.dart' if (dart.library.html) 'package:medcomp/views/login/webreal.dart';

class ProfilePage extends StatelessWidget {
  final name;
  final email;
  final photo;
  ProfilePage({@required this.name, @required this.email, @required this.photo});

  Widget defaultHeadline(
    str,
    bool small,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(small ? 0 : 20),
        left: ScreenUtil().setWidth(18),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          icon != null
              ? Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                  child: Icon(
                    icon,
                    color: ColorTheme.greyDark,
                    size: ScreenUtil().setHeight(20),
                  ),
                )
              : SizedBox(),
          Text(
            str,
            style: TextStyle(
              fontSize: ScreenUtil().setHeight(small ? 13 : 18),
              color: ColorTheme.greyDark,
              fontWeight: small ? FontWeight.w400 : FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Styles.responsiveBuilder(ui(context));
  }

  Widget ui(context) {
    var networkImage = NetworkImage(photo);
    return Scaffold(
      appBar: CustomAppBar.def(title: 'Profile', context: context),
      body: Column(
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
                      defaultHeadline(email, true, null),
                      defaultHeadline(name, false, null),
                    ],
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: ScreenUtil().setHeight(30),
                  backgroundImage: networkImage,
                ),
                SizedBox(width: ScreenUtil().setWidth(18)),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(40)),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SaviourPoster(img: networkImage)));
            },
            child: defaultHeadline('Saviour Poster', false, Icons.shield),
          ),
          GestureDetector(
            onTap: () {
              if (kIsWeb) {
                openSite(AppConfig.tnc);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => WebViewPage(link: AppConfig.tnc)),
                );
              }
            },
            child: defaultHeadline('Terms and Conditions', false, Icons.book),
          ),
          GestureDetector(
            onTap: () {
              if (kIsWeb) {
                openSite(AppConfig.prPolicy);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => WebViewPage(link: AppConfig.prPolicy)),
                );
              }
            },
            child: defaultHeadline('Privacy Policy', false, Icons.privacy_tip),
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(AppConfig.prefsSearchHistory);
              BlocProvider.of<HomeBloc>(context).add(HomeEventRefreshSearches());
              Navigator.pop(context);
              ToastPreset.successful(str: 'Cleared', context: context);
            },
            child: defaultHeadline('Clear Searches', false, Icons.clear),
          ),
          InkWell(
            onTap: () async {
              try {
                var res = await MyHttp.post('/logout', {});
                if (res.statusCode != 200) {
                  ToastPreset.err(context: context, str: 'Logout error ${res.statusCode}');
                }
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
              } catch (e) {
                print("logg out error : $e");
                ToastPreset.err(context: context, str: e);
              }
            },
            child: defaultHeadline('Log out', false, Icons.logout),
          ),
          Spacer(),
          Text(
            'Version build : ${Version.code}',
            style: TextStyle(fontSize: 11),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
