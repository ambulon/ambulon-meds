import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  GlobalKey _globalKey = new GlobalKey();
  Uint8List imgurl;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {
        imgurl = pngBytes;
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Widget To Image demo'),
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
                  child: Text('capture Image'),
                  onTap: _capturePng,
                ),
                new RaisedButton(
                  child: Text('share Image'),
                  onPressed: () async {
                    Share.file('esys image', 'ss32.png', imgurl, 'image/png', text: 'My optional text.');
                  },
                ),
                imgurl != null ? Container(width: double.infinity, height: 200, child: Image.memory(imgurl)) : SizedBox(),
                for (int i = 0; i < 100; i++) Text(i.toString()),
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
