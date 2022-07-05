import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class DashboardPage extends StatelessWidget {
  static String routeName = '/dashboardPage';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: FluidNavBar(
            icons: [
              FluidNavBarIcon(
                  icon: Icons.home, backgroundColor: Color(0xFF4285F4)),
              FluidNavBarIcon(
                  icon: Icons.monetization_on,
                  backgroundColor: Color(0xFFEC4134)),
              FluidNavBarIcon(
                  icon: Icons.ac_unit, backgroundColor: Color(0xFFFCBA02)),
              FluidNavBarIcon(
                  icon: Icons.alarm, backgroundColor: Color(0xFF34A950)),
            ],
            onChange: (val) {},
            style: const FluidNavBarStyle(
                iconUnselectedForegroundColor: Colors.white)),
      ),
    );
  }
}
