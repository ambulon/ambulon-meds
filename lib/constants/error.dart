import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final message;
  final bool canRetry;
  final function;

  ErrorPage({
    @required this.message,
    this.canRetry = false,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('error $message'),
      ),
    );
  }
}
