import 'package:flutter/material.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/flutter_toasts.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ChangeNotificationStatusWidget extends StatefulWidget {
  const ChangeNotificationStatusWidget({Key? key}) : super(key: key);

  @override
  State<ChangeNotificationStatusWidget> createState() =>
      _ChangeToDarkThemeWidgetState();
}

class _ChangeToDarkThemeWidgetState
    extends State<ChangeNotificationStatusWidget> {
  bool isNotificationOn = SharedService.isNotificationOn;

  void toggleSwitch(bool value) {
    if (isNotificationOn == false) {
      setState(() {
        isNotificationOn = true;
      });
      FlutterToasts.showNormalFlutterToast('Notifications turned off.');
    } else {
      setState(() {
        isNotificationOn = false;
      });
      FlutterToasts.showNormalFlutterToast('Notifications turned on.');
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
                Icons.notifications_active,
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
            const AutoSizeText(
              'Mute Notifications',
            ),
          ],
        ),
        Switch(
          onChanged: (isDarkMode) {
            toggleSwitch(isDarkMode);
          },
          value: isNotificationOn,
          activeColor: ThemeClass.primaryColor,
          splashRadius: 4,
        ),
      ],
    );
  }
}
