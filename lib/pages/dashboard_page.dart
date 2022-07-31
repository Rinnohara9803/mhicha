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

  Widget bottomNavItem(int tab, String label, IconData icon, Function onTap) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      minWidth: 40,
      onPressed: () {
        onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentTab == tab
                ? Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.white
                    : ThemeClass.primaryColor
                : Colors.grey,
          ),
          AutoSizeText(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: currentTab == tab
                  ? Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : ThemeClass.primaryColor
                  : Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

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
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: bottomNavItem(0, 'Home', Icons.home_rounded, () {
                      setState(() {
                        currentScreen = const HomePage();
                        currentTab = 0;
                      });
                    }),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: bottomNavItem(1, 'Statements', Icons.book, () {
                      setState(() {
                        currentScreen = const Page2();
                        currentTab = 1;
                      });
                    }),
                  ),
                ),
                const SizedBox(
                  width: 70,
                ), // Expanded(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Container(
                //         padding: const EdgeInsets.only(
                //           top: 25,
                //         ),
                //         child: const Text(
                //           'Scan and Pay',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             fontSize: 12,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: bottomNavItem(2, 'Payments', Icons.payment, () {
                      setState(() {
                        currentScreen = const PaymentsPage();
                        currentTab = 2;
                      });
                    }),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: bottomNavItem(3, 'Settings', Icons.settings, () {
                      setState(() {
                        currentScreen = SettingsPage(
                          returnToPreviousFunction: returnToPreviousPage,
                        );
                        currentTab = 3;
                      });
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
