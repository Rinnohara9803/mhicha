import 'package:flutter/material.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';

class ChangeToDarkThemeWidget extends StatefulWidget {
  const ChangeToDarkThemeWidget({Key? key}) : super(key: key);

  @override
  State<ChangeToDarkThemeWidget> createState() =>
      _ChangeToDarkThemeWidgetState();
}

class _ChangeToDarkThemeWidgetState extends State<ChangeToDarkThemeWidget> {
  bool isDarkMode = SharedService.isDarkMode;

  void toggleSwitch(bool value) {
    if (isDarkMode == false) {
      setState(() {
        isDarkMode = true;
      });
    } else {
      setState(() {
        isDarkMode = false;
      });
    }
  }

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
                Icons.dark_mode_outlined,
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
              'Dark Theme',
            ),
          ],
        ),
        Row(
          children: [
            Text(
              isDarkMode ? 'ON' : 'OFF',
            ),
            Switch(
              onChanged: (isDarkMode) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme()
                    .then((value) {
                  toggleSwitch(isDarkMode);
                });
              },
              value: isDarkMode,
              activeColor: ThemeClass.primaryColor,
              splashRadius: 4,
            ),
          ],
        ),
      ],
    );
  }
}
