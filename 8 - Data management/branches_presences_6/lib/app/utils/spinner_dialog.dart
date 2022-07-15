import 'package:flutter/material.dart';

class SpinnerDialog {
  static Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Image.asset(
              'assets/images/spinner_fast.gif',
              width: 100,
              height: 350,
            ),
          );
        });
  }
}
