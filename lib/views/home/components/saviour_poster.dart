import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/constants/toast.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

class SaviourPoster extends StatefulWidget {
  final NetworkImage img;
  SaviourPoster({@required this.img});
  @override
  _SaviourPosterState createState() => _SaviourPosterState();
}

class _SaviourPosterState extends State<SaviourPoster> {
  GlobalKey _globalKey = new GlobalKey();
  String text =
      'Every AMBULON user becomes a saviour as they share their profile page on their socials because\nwe donate sanitary pads to under privileged girl children and plant trees as our users increase, hence more you share, we\'ll get more users and you become as saviour.';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);
    return Styles.responsiveBuilder(page());
  }

  page() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Spacer(),
          Container(
            decoration: BoxDecoration(boxShadow: kElevationToShadow[8]),
            child: AspectRatio(
              aspectRatio: 0.82,
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  height: Styles.getHeight(context) * 0.5,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/posterbg.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Expanded(flex: 2, child: SizedBox()),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                    ),
                                    child: Text(
                                      text,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 3, child: SizedBox()),
                              ],
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: CircleAvatar(
                                      radius: Styles.getHeight(context) * 0.035,
                                      foregroundColor: Colors.redAccent,
                                      backgroundImage: widget.img,
                                    ),
                                  ),
                                ),
                                Expanded(flex: 3, child: SizedBox()),
                              ],
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          kIsWeb
              ? SizedBox()
              : ElevatedButton(
                  onPressed: () async {
                    try {
                      RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
                      if (boundary.debugNeedsPaint) {
                        ToastPreset.err(str: 'boundary debug needs paint', context: context);
                        return;
                      }
                      ui.Image image = await boundary.toImage(pixelRatio: 3);
                      final directory = (await getExternalStorageDirectory()).path;
                      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                      Uint8List pngBytes = byteData.buffer.asUint8List();
                      File imgFile = new File('$directory/screenshot.png');
                      imgFile.writeAsBytes(pngBytes);
                      final RenderBox box = context.findRenderObject();

                      Share.shareFiles(
                        ['$directory/screenshot.png'],
                        subject: 'Ambulon Saviour Poster',
                        text: '',
                        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                      );
                    } catch (e) {
                      ToastPreset.err(str: 'exception $e', context: context);
                    }
                  },
                  child: Text('Share Now'),
                ),
          Spacer(),
        ],
      ),
    );
  }
}
