import 'package:flutter/material.dart';
import 'package:mhicha/pages/send_money_page.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class FeatureRowWidgets extends StatelessWidget {
  const FeatureRowWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: Column(
              children: [
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    15,
                  ),
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      color: ThemeClass.primaryColor.withOpacity(
                        0.3,
                      ),
                    ),
                    height: 90,
                    child: Icon(
                      Icons.file_upload_outlined,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.white
                          : ThemeClass.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Load Money',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, SendMoneyPage.routeName, arguments: {
                'isDirectPay': true,
                'email': '',
              });
            },
            child: Column(
              children: [
                DottedBorder(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    15,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      color: ThemeClass.primaryColor.withOpacity(
                        0.3,
                      ),
                    ),
                    height: 90,
                    child: Icon(
                      Icons.screen_share_rounded,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.white
                          : ThemeClass.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Send Money',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InkWell(
            child: Column(
              children: [
                DottedBorder(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    15,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      color: ThemeClass.primaryColor.withOpacity(
                        0.3,
                      ),
                    ),
                    height: 90,
                    child: Icon(
                      Icons.smartphone,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.white
                          : ThemeClass.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Top - Up',
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
