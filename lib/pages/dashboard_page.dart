import 'package:flutter/material.dart';
import 'package:mhicha/pages/home_page.dart';
import 'package:mhicha/pages/statements_page.dart';
import 'package:mhicha/pages/payments_page.dart';
import 'package:mhicha/pages/settings_page.dart';
import 'package:mhicha/pages/qr_page.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = '/dashboardPage';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  void returnToPreviousPage() {
    setState(() {
      currentScreen = const HomePage();
      currentTab = 0;
    });
  }

  Widget currentScreen = const HomePage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeClass.primaryColor,
          onPressed: () {
            Navigator.of(context).pushNamed(QRPage.routeName);
          },
          child: const Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomePage();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: currentTab == 0
                                ? Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          AutoSizeText(
                            '   Home   ',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeClass.primaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Page2();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            color: currentTab == 1
                                ? Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          AutoSizeText(
                            'Statements',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeClass.primaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const PaymentsPage();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payment,
                            color: currentTab == 2
                                ? Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          AutoSizeText(
                            'Payments',
                            style: TextStyle(
                              color: currentTab == 2
                                  ? Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeClass.primaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = SettingsPage(
                            returnToPreviousFunction: returnToPreviousPage,
                          );
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: currentTab == 3
                                ? Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          AutoSizeText(
                            ' Settings ',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeClass.primaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
