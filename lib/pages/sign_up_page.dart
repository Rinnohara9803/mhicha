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
import 'package:provider/provider.dart';

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
                  Text(
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
                  TextFormField(
                    controller: _userNameController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your username.';
                      } else if (value.length <= 6) {
                        return 'Username should be at least 6 characters.';
                      }
                      return null;
                    },
                    onSaved: (text) {
                      _userNameController.text = text!;
                    },
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
                      label: const Text(
                        'Full Name',
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    onSaved: (text) {
                      _emailController.text = text!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.endsWith('.com')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
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
                      label: const Text(
                        'Email',
                      ),
                      prefixIcon: const Icon(
                        Icons.mail_outline,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    onSaved: (text) {
                      _passwordController.text = text!;
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your password.';
                      } else if (value.trim().length < 6) {
                        return 'Please enter at least 6 characters.';
                      }
                      return null;
                    },
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
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
                              : const Text(
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
                      Text(
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
                        child: Text(
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
