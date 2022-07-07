import 'package:flutter/material.dart';
import 'package:mhicha/pages/dashboard_page.dart';
import 'package:mhicha/pages/proceed_send_money_page.dart';
import 'package:mhicha/pages/qr_page.dart';
import 'package:mhicha/pages/send_money_page.dart';
import 'package:mhicha/pages/splash_page.dart';
import 'package:mhicha/pages/verify_email_page.dart';
import 'package:mhicha/pages/sign_in_page.dart';
import 'package:mhicha/pages/sign_up_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ThemeClass.primaryColor,
          ),
        ),
        home: const SplashPage(),
        routes: {
          SignInPage.routeName: (context) => const SignInPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          VerifyEmailPage.routeName: (context) => const VerifyEmailPage(),
          DashboardPage.routeName: (context) => const DashboardPage(),
          QRPage.routeName: (context) => const QRPage(),
          SendMoneyPage.routeName: (context) => const SendMoneyPage(),
          ProceedSendMoneyPage.routeName: (context) =>
              const ProceedSendMoneyPage(),
        },
      ),
    );
  }
}
