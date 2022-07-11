import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/constants.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/add_image_widget.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = '/editProfilePage';
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String userName = SharedService.userName;
  String email = SharedService.email;

  Future<void> updateProfile() async {
    try {
      await Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).updateProfile(userName, email).then((value) {
        SnackBars.showNormalSnackbar(
          context,
          'Profile updated successfully!!!',
        );
      });
    } on SocketException {
      SnackBars.showNoInternetConnectionSnackBar(context);
    } catch (e) {
      SnackBars.showErrorSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (userName == SharedService.userName && email == SharedService.email) {
      SnackBars.showNormalSnackbar(context, 'No changes to save.');
      return;
    }
    setState(() {
      _isLoading = true;
    });

    await updateProfile();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.289,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ThemeClass.primaryColor,
                                  const Color(0xff018AF3),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.navigate_before,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 100,
                            right: 8,
                            bottom: 8,
                            left: 8,
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue:
                                    Provider.of<ProfileProvider>(context)
                                        .userName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Username can\'t be empty';
                                  }
                                  if (value.length <= 6) {
                                    return 'Username should  be at least 7 characters.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: border,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                    .isDarkMode
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
                                    'Username',
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                  ),
                                ),
                                onSaved: (text) {
                                  userName = text!;
                                },
                                onChanged: (text) {
                                  userName = text;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                initialValue:
                                    Provider.of<ProfileProvider>(context).email,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@') ||
                                      !value.endsWith('.com')) {
                                    return 'Invalid email!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: border,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Provider.of<ThemeProvider>(context)
                                              .isDarkMode
                                          ? Colors.white60
                                          : Colors.black54,
                                    ),
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
                                  email = text!;
                                },
                                onChanged: (text) {
                                  email = text;
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1),
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
                                              'Update Profile',
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
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.189,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddImageWidget(
                        getUserProfilePhoto: () {},
                      ),
                    ],
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
