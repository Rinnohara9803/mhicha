import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:mhicha/widgets/general_textformfield.dart';
import '../utilities/themes.dart';

class ResetOtpPage extends StatefulWidget {
  static String routeName = '/resetOtpPage';
  const ResetOtpPage({Key? key}) : super(key: key);

  @override
  State<ResetOtpPage> createState() => ResetOtpPageState();
}

class ResetOtpPageState extends State<ResetOtpPage> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<ProfileProvider>(context, listen: false)
          .resetPassword(
        otpController.text,
        newPasswordController.text,
      )
          .then((_) {
        SnackBars.showNormalSnackbar(
            context, 'Password updated successfully!!!');
        Navigator.pop(context);
      });
    } on SocketException {
      SnackBars.showNoInternetConnectionSnackBar(context);
    } catch (e) {
      SnackBars.showErrorSnackBar(context, 'Invalid or Expired OTP!!!');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 145,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      const Color(0xff018AF3),
                      ThemeClass.primaryColor,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(
                      50,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.navigate_before,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const AutoSizeText(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 15,
                    right: 15,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          GeneralTextFormField(
                            hasPrefixIcon: false,
                            hasSuffixIcon: false,
                            controller: otpController,
                            label: 'OTP',
                            textInputType: TextInputType.name,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please provide sent otp.';
                              }
                              if (value.trim().length > 6) {
                                return 'length exceeded.';
                              }
                              return null;
                            },
                            iconData: Icons.mail_outline,
                            autoFocus: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GeneralTextFormField(
                            hasPrefixIcon: true,
                            hasSuffixIcon: true,
                            controller: newPasswordController,
                            label: 'New Password',
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter your password.';
                              } else if (value.trim().length < 6) {
                                return 'Please enter at least 6 characters.';
                              }
                              return null;
                            },
                            textInputType: TextInputType.name,
                            iconData: Icons.lock,
                            autoFocus: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            child: InkWell(
                              onTap: () async {
                                await _saveForm();
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ThemeClass.primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Center(
                                  child: _isLoading
                                      ? const ProgressIndicator1()
                                      : const AutoSizeText(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
