import 'package:flutter/material.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/services/shared_services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = SharedService.isDarkMode;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isDarkMode == false) {
      setState(() {
        SharedService.isDarkMode = true;
        isDarkMode = true;
      });
    } else {
      setState(() {
        SharedService.isDarkMode = false;
        isDarkMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              await AuthService.logOut(context);
            },
            icon: const Icon(Icons.logout),
            label: const Text(
              'Logout',
            ),
          ),
          Switch(
            onChanged: toggleSwitch,
            value: isDarkMode,
            activeColor: Colors.blue,
            activeTrackColor: Colors.yellow,
            inactiveThumbColor: Colors.redAccent,
            inactiveTrackColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
