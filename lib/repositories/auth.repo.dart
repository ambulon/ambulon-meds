import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:medcomp/views/home/home.dart';
import 'package:medcomp/constants/loading.popup.dart';
import 'package:medcomp/constants/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static void gsignin(context) async {
    LoadingPopupGenerator.def(text: 'Fetching Account', context: context);
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {}
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final User user = (await _firebaseAuth.signInWithCredential(credential)).user;

      await AuthRepo.saveUser(user, context);
    } catch (e) {
      Navigator.pop(context);
      ToastPreset.err(context: context, str: 'Error $e');
    }
  }

  static Future<void> saveUser(User user, context) async {
    var res = await MyHttp.get('/get-token/${user.uid}');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      String token = body["token"];
      print("token : $token");
      if (token != null) {
        print("token recieved");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Home()),
        );
      } else {
        throw ("No token");
      }
    } else {
      var body = jsonDecode(res.body);
      if (body["message"] != 'user not added') {
        throw ("res ${res.statusCode} ${res.body}");
      } else {
        var data = {
          'f_id': user.uid,
          'name': user.displayName,
          'age': 1,
          'imageUrl': user.photoURL,
          'email': user.email,
        };
        var signupRes = await MyHttp.post('/add-user', data);
        if (signupRes.statusCode == 200) {
          var getTokenBody = jsonDecode(signupRes.body);
          String token = getTokenBody["token"];
          if (token != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', token);
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Home()),
            );
          } else {
            throw ("No token signup");
          }
        } else {
          var sbody = jsonDecode(signupRes.body);
          throw ('signup ${signupRes.statusCode} $sbody');
        }
      }
    }
  }
}
