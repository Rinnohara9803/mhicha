import 'package:flutter/material.dart';
import 'package:mhicha/pages/profile_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfileSettingsWidget extends StatelessWidget {
  const ProfileSettingsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: CircleAvatar(
            radius: 39,
            backgroundColor: Colors.white,
            child: Hero(
              tag: 'profileImage',
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'images/profile_avatar.png',
                ),
                radius: 37,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  Provider.of<ProfileProvider>(context).userName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                AutoSizeText(
                  'Personal Info',
                  style: TextStyle(
                      fontSize: 15,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.white60
                          : Colors.black45),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.white30
                    : Colors.black12,
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ProfilePage.routeName,
                  );
                },
                icon: const Icon(
                  Icons.navigate_next,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
