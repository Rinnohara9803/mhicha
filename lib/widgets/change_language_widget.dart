import 'package:flutter/material.dart';
import 'package:mhicha/l10n/l10n.dart';
import 'package:mhicha/providers/locale_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageWidget> createState() => ChangeLanguageWidgetState();
}

class ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  void showChangeLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      backgroundColor:
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode
              ? Colors.black
              : Colors.white,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(
            12,
          ),
          height: 170,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.language,
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  AutoSizeText(
                    'Change Language',
                    style: TextStyle(
                      fontSize: 20,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  children: L10n.all.map(
                    (locale) {
                      final flag = L10n.getFlag(locale.languageCode);
                      return Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (locale == const Locale('en')) {
                                prefs.setBool('isLanguageEnglish', true);
                              } else {
                                prefs.setBool('isLanguageEnglish', false);
                              }

                              Provider.of<LocaleProvider>(context,
                                      listen: false)
                                  .setLocale(locale);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              flag,
                              style: const TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white
                  : ThemeClass.primaryColor.withOpacity(
                      0.7,
                    ),
              child: Icon(
                Icons.language,
                size: 22.0,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.black
                    : Colors.white,
              ),
              padding: const EdgeInsets.all(
                15,
              ),
              shape: const CircleBorder(),
            ),
            const Text(
              'Languages',
            ),
          ],
        ),
        Row(
          children: [
            Text(
              Provider.of<LocaleProvider>(context, listen: true).locale ==
                      L10n.all[0]
                  ? 'English'
                  : 'Nepali',
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 10,
              ),
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
                  showChangeLanguageBottomSheet();
                },
                icon: const Icon(
                  Icons.navigate_next,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
