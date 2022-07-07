import 'dart:async';

import 'package:flutter/material.dart';

class SlidingWidgets extends StatefulWidget {
  const SlidingWidgets({Key? key}) : super(key: key);

  @override
  State<SlidingWidgets> createState() => _SlidingWidgetsState();
}

class _SlidingWidgetsState extends State<SlidingWidgets> {
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  bool end = false;
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      if (_currentPage == 2) {
        end = true;
      } else if (_currentPage == 0) {
        end = false;
      }

      if (end == false) {
        _currentPage++;
      } else {
        _currentPage--;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: const [
        FadeInImage(
          fit: BoxFit.fill,
          placeholder: AssetImage(
            'images/loading.gif',
          ),
          placeholderFit: BoxFit.cover,
          image: NetworkImage(
            'https://previews.123rf.com/images/rawpixel/rawpixel1603/rawpixel160301612/52968758-go-digital-technology-information-network-e-business-concept.jpg',
          ),
        ),
        FadeInImage(
          fit: BoxFit.fill,
          placeholderFit: BoxFit.cover,
          placeholder: AssetImage(
            'images/loading.gif',
          ),
          image: NetworkImage(
            'https://olymptradeforum.com/images/olymptrade/1616169415316/original/what-are-the-advantages-of-using-an-e-wallet-on-olymp-trade.png',
          ),
        ),
        FadeInImage(
          fit: BoxFit.fill,
          placeholderFit: BoxFit.cover,
          placeholder: AssetImage(
            'images/loading.gif',
          ),
          image: NetworkImage(
            'https://assets-global.website-files.com/5cb303852da2ad609e57122e/5eda2b684bc6a527220f5241_Scan%20%26%20Pay.png',
          ),
        ),
      ],
    );
  }
}
