import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String link;
  WebViewPage({@required this.link});
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.def(context: context, title: ''),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.link,
      ),
    );
  }
}
