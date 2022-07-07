import 'package:flutter/material.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/add_image_widget.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = '/editProfilePage';
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
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
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.35,
                child: AddImageWidget(
                  getUserProfilePhoto: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
