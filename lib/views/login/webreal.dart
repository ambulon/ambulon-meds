import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

openSite(url) {
  if (kIsWeb) {
    html.window.open(url, 'new tab');
  }
}
