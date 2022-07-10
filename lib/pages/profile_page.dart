import 'package:flutter/material.dart';
import 'package:mhicha/pages/edit_profile_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = '/profilePage';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget profileDetailBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.white
                : Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.white70
                : ThemeClass.primaryColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theHeight = MediaQuery.of(context).size.height;
    final theWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: theHeight * 0.230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(
                        55,
                      ),
                    ),
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
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 30,
                                right: 40,
                                top: 70,
                                bottom: 20,
                              ),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(
                                  10,
                                ),
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                child: Container(
                                  height: 95,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 40,
                                    top: 20,
                                    bottom: 20,
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
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(
                                              Icons.account_balance_wallet,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Rs. ${Provider.of<ProfileProvider>(context).balance}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'Total Balance',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 60,
                                top: 15,
                                right: 40,
                                bottom: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  profileDetailBox(
                                    'Your email',
                                    SharedService.email,
                                  ),
                                  profileDetailBox(
                                      'Your password', '*********'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: theHeight * 0.13,
              left: theWidth * 0.09,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: 'profileImage',
                    child: CircleAvatar(
                      radius: theWidth * 0.14,
                      backgroundColor: ThemeClass.primaryColor.withOpacity(
                        0.6,
                      ),
                      child: CircleAvatar(
                        radius: theWidth * 0.135,
                        backgroundColor: Colors.black12,
                        backgroundImage: const AssetImage(
                          'images/profile_avatar.png',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -14,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ThemeClass.primaryColor,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.verified_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: theHeight * 0.168,
              left: theWidth * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Provider.of<ProfileProvider>(
                      context,
                    ).userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: theHeight * 0.008,
              left: 30,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, EditProfilePage.routeName);
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 5,
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
