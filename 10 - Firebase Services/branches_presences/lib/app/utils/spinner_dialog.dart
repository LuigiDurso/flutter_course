import 'package:flutter/material.dart';

class SpinnerDialog {
  static var isOpen = false;

  static Future<dynamic> buildShowDialog(BuildContext context) {
    SpinnerDialog.isOpen = true;
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
        }).then((value) => SpinnerDialog.isOpen = false);
  }

  static void closeSpinnerDialog(NavigatorState navigatorState) {
    if (SpinnerDialog.isOpen) {
      navigatorState.pop();
    }
  }
}
