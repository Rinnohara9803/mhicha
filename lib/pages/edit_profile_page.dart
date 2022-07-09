import 'package:flutter/material.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/services/shared_services.dart';
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

  Future<void> updateProfile() async {}

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (userName == SharedService.userName && email == SharedService.email) {
      SnackBars.showNormalSnackbar(context, 'No changes to save.');
    }
    setState(() {
      _isLoading = true;
    });
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
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.red),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: ThemeClass.primaryColor),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: ThemeClass.primaryColor),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  label: const Text(
                                    'Username',
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.mail_outline,
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
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.red),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: ThemeClass.primaryColor),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: ThemeClass.primaryColor),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  label: const Text(
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
                                          : const Text(
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
