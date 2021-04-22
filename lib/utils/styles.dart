import 'package:flutter/cupertino.dart';

class Styles {
  // Aspect Ratio taken is H/W = 1.7, w = h/1.7
  static const int h_small_for_loginpage = 730;
  static const int h_small = 700;
  static const int w_small = 410;

  static const int h_medium = 900;
  static const int w_medium = 520;

  static const int h_large = 1100;
  static const int w_large = 700;

  static const int h_tablet = 1200;
  static const int w_tablet = 800;

  // ignore: non_constant_identifier_names
  static get_width(context) {
    // ignore: non_constant_identifier_names
    double device_w = MediaQuery.of(context).size.width;
    // print("Device W : $device_w");
    if (device_w < 420) {
      return w_small;
    } else if (device_w < 500) {
      return w_medium;
    } else if (device_w < 790) {
      return w_large;
    } else {
      return w_tablet;
    }
  }

  // ignore: non_constant_identifier_names
  static get_height(context) {
    // ignore: non_constant_identifier_names
    double device_h = MediaQuery.of(context).size.height;
    if (device_h < 700) {
      return h_small;
    } else if (device_h < 1000) {
      return h_medium;
    } else if (device_h < 1190) {
      return h_large;
    } else {
      return h_tablet;
    }
  }
}
