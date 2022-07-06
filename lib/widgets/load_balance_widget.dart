import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mhicha/utilities/themes.dart';

class LoadBalanceWidget extends StatelessWidget {
  const LoadBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(
        15,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeClass.primaryColor.withOpacity(
              0.3,
            ),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          height: 150,
          child: Icon(
            Icons.add,
            size: 30,
            color: ThemeClass.primaryColor,
          ),
        ),
      ),
    );
  }
}
