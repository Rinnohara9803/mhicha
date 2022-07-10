import 'package:flutter/material.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';

class HelpSettingsWidget extends StatefulWidget {
  const HelpSettingsWidget({Key? key}) : super(key: key);

  @override
  State<HelpSettingsWidget> createState() => HelpSettingsWidgetState();
}

class HelpSettingsWidgetState extends State<HelpSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white
                  : ThemeClass.primaryColor.withOpacity(
                      0.7,
                    ),
              child: Icon(
                Icons.help_outline_outlined,
                size: 22.0,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.black
                    : Colors.white,
              ),
              padding: const EdgeInsets.all(
                15,
              ),
              shape: const CircleBorder(),
            ),
            const Text(
              'Help',
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 10,
          ),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.white30
                : Colors.black12,
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.navigate_next,
            ),
          ),
        ),
      ],
    );
  }
}
