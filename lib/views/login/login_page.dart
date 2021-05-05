import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:medcomp/views/home/home.dart';
import 'package:medcomp/widget_constants/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void gsignin() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {}
    try {
      setState(() {
        isLoading = true;
      });
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final User user = (await _firebaseAuth.signInWithCredential(credential)).user;

      await apiSave(user);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      ToastPreset.err(context: context, str: 'Error in gsign-in');
      print("Error in gsignin try catch : $e");
    }
  }

  Future<void> apiSave(User user) async {
    try {
      var res = await MyHttp.get('/get-token/${user.uid}');
      if (res.statusCode == 200) {
        print("logged in getting token");
        var body = jsonDecode(res.body);
        String token = body["token"];
        if (token != null) {
          print("token recieved");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Home()),
          );
        } else {
          ToastPreset.err(context: context, str: 'No token');
        }
      } else if (res.statusCode == 422) {
        var body = jsonDecode(res.body);
        if (body["message"] == 'user not added') {
          // register
          print("user not added, adding now");
          ToastPreset.successful(context: context, str: 'Signing you up');
          try {
            var data = {
              'f_id': user.uid,
              'name': user.displayName,
              'age': 1,
              'imageUrl': user.photoURL,
              'email': user.email,
            };
            var signupRes = await MyHttp.post('/add-user', data);
            if (signupRes.statusCode == 200) {
              print("user add getting token");
              var getTokenBody = jsonDecode(signupRes.body);
              String token = getTokenBody["token"];
              if (token != null) {
                print("token recieved");
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('token', token);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Home()),
                );
              } else {
                ToastPreset.err(context: context, str: 'Token not recieved');
              }
            } else if (signupRes.statusCode == 400) {
              var sbody = jsonDecode(res.body);
              ToastPreset.err(context: context, str: 'Already exists');
              print('Error in signup api ${signupRes.statusCode} $sbody');
            } else {
              var sbody = jsonDecode(res.body);
              ToastPreset.err(context: context, str: 'Error ${signupRes.statusCode}');
              print('Error in signup api ${signupRes.statusCode} $sbody');
            }
          } catch (e) {
            ToastPreset.err(context: context, str: 'Error in signup api');
            print('Error in signup api $e');
          }
        } else {
          print("error res 422 ${res.body}");
          ToastPreset.err(context: context, str: 'Error res: ${res.statusCode}');
        }
      } else {
        print("Error res ${res.statusCode} ${res.body}");
        ToastPreset.err(context: context, str: 'Error res : ${res.statusCode}');
      }
    } catch (e) {
      ToastPreset.err(context: context, str: 'Error in login api');
      print("Error in login api try catch : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.teal[900],
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(0, -0.50),
                child: Container(
                  child: Text(
                    'AMBULON MEDS',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.65),
                child: GestureDetector(
                  onTap: gsignin,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      // color: ColorPalette.BLUE,
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Login with Google',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              isLoading
                  ? Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.teal[900],
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          backgroundColor: Colors.teal[900],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
