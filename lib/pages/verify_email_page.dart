import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mhicha/pages/dashboard_page.dart';
import 'package:mhicha/pages/sign_in_page.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:pinput/pinput.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  static String routeName = '/inputPinPage';

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String otp = '';

  Future<void> _verifyOtp(String otp) async {
    try {
      await AuthService.verifyUser(otp).then((value) {
        SnackBars.showNormalSnackbar(context, 'Verification successfull!!!');
        Navigator.pushReplacementNamed(
          context,
          DashboardPage.routeName,
        );
      });
    } on SocketException {
      SnackBars.showNoInternetConnectionSnackBar(context);
    } catch (e) {
      SnackBars.showErrorSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeQuery = MediaQuery.of(context).size;
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: ThemeClass.primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: ThemeClass.primaryColor.withOpacity(
          0.2,
        ),
      ),
    );
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.bottom -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const PhoneViewTopWidget(
                  text1: 'Verification',
                  text2: 'Code',
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 33,
                                  bottom: 15,
                                ),
                                child: const Text(
                                  'Please enter code sent to',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(
                                      0xff605A65,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    email,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Pinput(
                              keyboardType: TextInputType.emailAddress,
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              onCompleted: (pin) {
                                otp = pin;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        InkWell(
                          onTap: otp.isEmpty
                              ? null
                              : () async {
                                  await _verifyOtp(otp);
                                },
                          child: Container(
                            height: sizeQuery.height * 0.065,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ThemeClass.primaryColor,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 1,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Resend Code',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account ? ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignInPage.routeName);
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: ThemeClass.primaryColor,
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class PhoneViewTopWidget extends StatelessWidget {
  final String text1;
  final String text2;
  const PhoneViewTopWidget({required this.text1, required this.text2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeQuery = MediaQuery.of(context).size;
    return Container(
      height: sizeQuery.height * 0.27,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(
            200,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xff018AF3),
            ThemeClass.primaryColor,
          ],
        ),
      ),
      padding: EdgeInsets.only(
        left: sizeQuery.width * 0.1,
        top: sizeQuery.height * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            text2,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
