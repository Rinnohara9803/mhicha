import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mhicha/models/user.dart';
import 'package:mhicha/pages/sign_in_page.dart';
import 'package:mhicha/pages/verify_email_page.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/utilities/constants.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:mhicha/widgets/general_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const routeName = '/signUpPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  User newUser = User(
    userName: '',
    email: '',
    password: '',
  );

  bool isVisible = true;
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState!.save();
    newUser = User(
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      await AuthService.signUpUser(newUser).then((value) {
        SnackBars.showNormalSnackbar(context, 'Account created Successfully!!');
        Navigator.of(context).pushReplacementNamed(
          VerifyEmailPage.routeName,
          arguments: _emailController.text,
        );
      });
    } on SocketException {
      SnackBars.showNoInternetConnectionSnackBar(context);
    } catch (e) {
      SnackBars.showErrorSnackBar(context, e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 30,
            ),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset(
                    'images/mhicha.png',
                    height: 180,
                    width: 180,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeClass.primaryColor,
                      fontSize: 35,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GeneralTextFormField(
                    hasPrefixIcon: true,
                    hasSuffixIcon: false,
                    controller: _userNameController,
                    label: 'Full Name',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your username.';
                      } else if (value.length <= 6) {
                        return 'Username should be at least 6 characters.';
                      }
                      return null;
                    },
                    textInputType: TextInputType.name,
                    iconData: Icons.person,
                    autoFocus: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GeneralTextFormField(
                    hasPrefixIcon: true,
                    hasSuffixIcon: false,
                    controller: _emailController,
                    label: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.endsWith('.com')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    textInputType: TextInputType.emailAddress,
                    iconData: Icons.mail_outline,
                    autoFocus: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GeneralTextFormField(
                    hasPrefixIcon: true,
                    hasSuffixIcon: true,
                    controller: _passwordController,
                    label: 'Password',
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AutoSizeText(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : ThemeClass.primaryColor,
                          fontSize: 15,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Already have an account ? ',
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white60
                              : Colors.black54,
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
                        child: AutoSizeText(
                          'Sign In',
                          style: TextStyle(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : ThemeClass.primaryColor,
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
        ),
      ),
    );
  }
}
