import 'package:flutter/material.dart';
import 'package:mhicha/utilities/themes.dart';

class SnackBars {
  static void showNormalSnackbar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(
          milliseconds: 2500,
        ),
        backgroundColor: ThemeClass.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(content),
        backgroundColor: const Color.fromARGB(255, 189, 86, 80),
        duration: const Duration(
          milliseconds: 2500,
        ),
      ),
    );
  }

  static void showNoInternetConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No internet connection.'),
        duration: Duration(
          milliseconds: 2500,
        ),
      ),
    );
  }
}
