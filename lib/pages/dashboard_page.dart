import 'package:flutter/material.dart';
import 'package:mhicha/pages/home_page.dart';
import 'package:mhicha/pages/page2.dart';
import 'package:mhicha/pages/page3.dart';
import 'package:mhicha/pages/settings_page.dart';
import 'package:mhicha/pages/qr_page.dart';
import 'package:mhicha/utilities/themes.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = '/dashboardPage';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentTab = 0;
  List tabs = const [
    HomePage(),
    Page2(),
    Page3(),
    SettingsPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

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
                                ? ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            '   Home   ',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? ThemeClass.primaryColor
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
                                ? ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            'Statements',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? ThemeClass.primaryColor
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
                          currentScreen = const Page3();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payment,
                            color: currentTab == 3
                                ? ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            'Payments',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? ThemeClass.primaryColor
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
                          currentScreen = const SettingsPage();
                          currentTab = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: currentTab == 4
                                ? ThemeClass.primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            ' Settings ',
                            style: TextStyle(
                              color: currentTab == 4
                                  ? ThemeClass.primaryColor
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
