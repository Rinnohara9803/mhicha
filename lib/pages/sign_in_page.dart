import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mhicha/pages/dashboard_page.dart';
import 'package:mhicha/pages/sign_up_page.dart';
import 'package:mhicha/pages/verify_email_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/constants.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const String routeName = '/signInPage';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthService.signInuser(
              _emailController.text, _passwordController.text)
          .then((value) async {
        await Provider.of<ProfileProvider>(context, listen: false)
            .getMyProfile()
            .then((value) {
          if (SharedService.isVerified) {
            Navigator.pushReplacementNamed(context, DashboardPage.routeName);
          } else {
            Navigator.pushReplacementNamed(
              context,
              VerifyEmailPage.routeName,
              arguments: SharedService.email,
            );
          }
        });
      });
    } on SocketException {
      SnackBars.showNoInternetConnectionSnackBar(context);
    } catch (e) {
      SnackBars.showErrorSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool isVisible = true;
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
                    'Sign In',
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
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.endsWith('.com')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: border,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white60
                                    : Colors.black54),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      errorBorder: errorBorder,
                      focusedBorder: focusedBorder,
                      focusedErrorBorder: focusedErrorBorder,
                      label: const AutoSizeText(
                        'Email',
                      ),
                      prefixIcon: const Icon(
                        Icons.mail_outline,
                      ),
                    ),
                    onSaved: (text) {
                      _emailController.text = text!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      border: border,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white60
                                    : Colors.black54),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      errorBorder: errorBorder,
                      focusedBorder: focusedBorder,
                      focusedErrorBorder: focusedErrorBorder,
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your password.';
                      } else if (value.trim().length < 6) {
                        return 'Please enter at least 6 characters.';
                      }
                      return null;
                    },
                    onSaved: (text) {
                      _passwordController.text = text!;
                    },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Material(
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
                                        'Sign In',
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
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Don\'t have an account ? ',
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
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
                              .pushReplacementNamed(SignUpPage.routeName);
                        },
                        child: AutoSizeText(
                          'Sign Up',
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
