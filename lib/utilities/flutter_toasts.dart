import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class FlutterToasts {
  static void showNormalFlutterToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
