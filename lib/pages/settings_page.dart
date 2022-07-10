import 'package:flutter/material.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/widgets/change_theme_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,
        width: MediaQuery.of(context).size.width,
        child: Column(
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
            const ChangeToDarkThemeWidget(),
          ],
        ),
      ),
    );
  }
}
