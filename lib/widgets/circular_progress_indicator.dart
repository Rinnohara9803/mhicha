import 'package:flutter/material.dart';

class ProgressIndicator1 extends StatelessWidget {
  const ProgressIndicator1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.0,
      ),
    );
  }
}
