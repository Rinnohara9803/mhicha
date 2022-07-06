import 'package:flutter/material.dart';

class SendMoneyPage extends StatefulWidget {
  static String routeName = '/sendMoneyPage';
  const SendMoneyPage({Key? key}) : super(key: key);

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final userName = routeArgs['userName'] as String;
    final email = routeArgs['email'] as String;
    final isVerified = routeArgs['isVerified'] as bool;
    return SafeArea(
      child: Scaffold(
        body: Text(userName),
      ),
    );
  }
}
