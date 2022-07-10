import 'package:flutter/material.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/shared_services.dart';
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
      children: [
        const Text(
          'Dark Theme',
        ),
        Switch(
          onChanged: (isDarkMode) {
            Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            toggleSwitch(isDarkMode);
          },
          value: isDarkMode,
          activeColor: Colors.white,
          splashRadius: 4,
        ),
      ],
    );
  }
}
