import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/constants/toast.dart';
import 'package:medcomp/constants/web.view.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/main.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/home/components/saviour_poster.dart';
import 'package:medcomp/views/login/login_page.dart';
import 'package:medcomp/views/login/webfake.dart' if (dart.library.html) 'package:medcomp/views/login/webreal.dart';
import 'package:settings_ui/settings_ui.dart';

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
              fontSize: ScreenUtil().setHeight(small ? 15 : 18),
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
      body: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: ScreenUtil().setWidth(35)),
                                child: CircleAvatar(
                                  radius: ScreenUtil().setHeight(40),
                                  backgroundImage: networkImage,
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setWidth(10)),
                              defaultHeadline(email, true, null),
                              SizedBox(height: ScreenUtil().setWidth(5)),
                              defaultHeadline(name, false, null),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(18)),
                      ],
                    ),
                  ),
            
                  SizedBox(height: ScreenUtil().setHeight(10)),

                    SettingsList(
                      shrinkWrap: true,
                      physics: PageScrollPhysics(),
                      lightTheme: SettingsThemeData(settingsListBackground: Colors.white),
                      sections: [
                      SettingsSection(
                        title: Text('Main Settings',
                        style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setHeight(20),
                       ),
                       ),
                        tiles: [
                          SettingsTile.navigation(
                            leading: Icon(Icons.shield),
                            title: Text('Saviour Poster'),
                            onPressed: (BuildContext ctx) {
                              Navigator.push(context, MaterialPageRoute(builder: (ctx) => SaviourPoster(img: networkImage)));
                            },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.book),
                            title: Text('Terms and Conditions'),
                            onPressed: (BuildContext ctx) {
                              if (kIsWeb) {
                              openSite(AppConfig.tnc);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (ctx) => WebViewPage(link: AppConfig.tnc)),
                              );
                            }
                          },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.privacy_tip),
                            title: Text('Privacy Policy'),
                            onPressed: (BuildContext ctx) {
                        if (kIsWeb) {
                          openSite(AppConfig.prPolicy);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (ctx) => WebViewPage(link: AppConfig.prPolicy)),
                          );
                        }
                      },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.clear),
                            title: Text('Clear Searches'),
                            onPressed: (BuildContext ctx) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove(AppConfig.prefsSearchHistory);
                        BlocProvider.of<HomeBloc>(ctx).add(HomeEventRefreshSearches());
                        Navigator.pop(ctx);
                        ToastPreset.successful(str: 'Cleared', context: context);
                      },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                            onPressed: (BuildContext context) async {
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
                          ),
                          CustomSettingsTile(child:  
                         Divider(
                           height: 10,
                           thickness: 1,
                           color: Colors.black26,
                          ),
                          ),
                        ],
                      ),
                  ],
                ),


                SettingsList(
                      shrinkWrap: true,
                      physics: PageScrollPhysics(),
                      lightTheme: SettingsThemeData(settingsListBackground: Colors.white),
                      sections: [
                      SettingsSection(
                        title: Text('User Settings',
                        style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setHeight(20),
                       ),
                       ),
                        tiles: [
                          
                          SettingsTile.navigation(
                            leading: Icon(Icons.shield),
                            title: Text('Saviour Poster'),
                            onPressed: (BuildContext ctx) {
                              Navigator.push(context, MaterialPageRoute(builder: (ctx) => SaviourPoster(img: networkImage)));
                            },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.book),
                            title: Text('Terms and Conditions'),
                            onPressed: (BuildContext ctx) {
                              if (kIsWeb) {
                              openSite(AppConfig.tnc);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (ctx) => WebViewPage(link: AppConfig.tnc)),
                              );
                            }
                          },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.privacy_tip),
                            title: Text('Privacy Policy'),
                            onPressed: (BuildContext ctx) {
                        if (kIsWeb) {
                          openSite(AppConfig.prPolicy);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (ctx) => WebViewPage(link: AppConfig.prPolicy)),
                          );
                        }
                      },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.clear),
                            title: Text('Clear Searches'),
                            onPressed: (BuildContext ctx) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove(AppConfig.prefsSearchHistory);
                        BlocProvider.of<HomeBloc>(ctx).add(HomeEventRefreshSearches());
                        Navigator.pop(ctx);
                        ToastPreset.successful(str: 'Cleared', context: context);
                      },
                          ),
                          SettingsTile.navigation(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                            onPressed: (BuildContext context) async {
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
                          ),
                         CustomSettingsTile(child:  
                         Divider(
                           height: 10,
                           thickness: 1,
                           color: Colors.black26,
                          ),
                          ),
                        ],
                      

                      ),
                  ],
                ),
                    
                SizedBox(height: 20),

                  Spacer(),
                  Text(
                    'Version build : ${Version.code}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(height: 12),
              
            ]
          )
          ),
      ],
    ),
    );
  }
}
