import 'package:flutter/material.dart';
import 'package:mhicha/pages/sign_in_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple.withOpacity(
          0.7,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/mhicha.png',
                height: 150,
                width: 150,
              ),
              const Text(
                'mhicha',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  fontFamily: 'Lato',
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
