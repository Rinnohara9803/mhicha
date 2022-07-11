import 'package:flutter/material.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/change_theme_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mhicha/widgets/aboutus_settings_widget.dart';
import 'package:mhicha/widgets/notifications_settings_widget.dart';
import 'package:mhicha/widgets/profile_settings_widget.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final Function returnToPreviousFunction;
  const SettingsPage({Key? key, required this.returnToPreviousFunction})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 20,
        ),
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    widget.returnToPreviousFunction();
                  },
                  child: const Icon(
                    Icons.navigate_before,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                    left: 20,
                  ),
                  child: AutoSizeText(
                    'Settings',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 40,
                      right: 20,
                      left: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          AutoSizeText(
                            'Account',
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ProfileSettingsWidget(),
                          SizedBox(
                            height: 30,
                          ),
                          AutoSizeText(
                            'Settings',
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ChangeToDarkThemeWidget(),
                          SizedBox(
                            height: 15,
                          ),
                          ChangeNotificationStatusWidget(),
                          SizedBox(
                            height: 15,
                          ),
                          AboutUsSettingsWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: TextButton.icon(
                onPressed: () async {
                  await AuthService.logOut(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : ThemeClass.primaryColor,
                ),
                label: AutoSizeText(
                  'Logout',
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.white
                        : ThemeClass.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
