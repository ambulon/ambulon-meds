import 'package:flutter/material.dart';

class TempShare extends StatefulWidget {
  @override
  _TempShareState createState() => _TempShareState();
}

class _TempShareState extends State<TempShare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.80,
              color: Colors.redAccent,
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/banner1.jpg',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'here presenting to you',
                        style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 22.0),
                      )),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
