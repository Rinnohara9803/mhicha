import 'package:flutter/material.dart';
import 'package:mhicha/pages/sign_in_page.dart';
import 'package:mhicha/pages/splash_page.dart';
import 'package:mhicha/utilities/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: ThemeClass.primaryColor,
        ),
      ),
      home: const SplashPage(),
      routes: {
        SignInPage.routeName: (context) => const SignInPage(),
      },
    );
  }
}
