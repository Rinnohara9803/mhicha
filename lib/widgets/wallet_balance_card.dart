import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/animated_icon_widget.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WalletBalanceCard extends StatefulWidget {
  const WalletBalanceCard({Key? key}) : super(key: key);

  @override
  State<WalletBalanceCard> createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends State<WalletBalanceCard> {
  bool _isBalanceVisible = false;
  final controller = AnimateIconController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ThemeClass.primaryColor,
            const Color(0xff018AF3),
          ],
        ),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      height: 190,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AutoSizeText(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
              InkWell(
                onTap: () async {
                  try {
                    await Provider.of<ProfileProvider>(
                      context,
                      listen: false,
                    ).getMyProfile();
                  } on SocketException {
                    SnackBars.showNoInternetConnectionSnackBar(context);
                  } catch (e) {
                    SnackBars.showErrorSnackBar(context, e.toString());
                  }
                },
                child: AnimateIconsWidget(
                  startIcon: Icons.refresh,
                  endIcon: Icons.refresh,
                  size: 28.0,
                  controller: controller,
                  startTooltip: 'Icons.refresh',
                  endTooltip: 'Icons.refresh',
                  splashColor: Colors.white,
                  splashRadius: 24,
                  onStartIconPress: () {
                    // print('here 1');
                    return true;
                  },
                  onEndIconPress: () {
                    // print('here 2');
                    return true;
                  },
                  duration: const Duration(milliseconds: 500),
                  startIconColor: Colors.white,
                  endIconColor: Colors.white,
                  clockwise: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                child: AutoSizeText(
                  !_isBalanceVisible
                      ? 'XXX.XX'
                      : 'Rs. ${Provider.of<ProfileProvider>(context).balance}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
