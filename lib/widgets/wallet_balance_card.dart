import 'package:flutter/material.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WalletBalanceCard extends StatefulWidget {
  const WalletBalanceCard({Key? key}) : super(key: key);

  @override
  State<WalletBalanceCard> createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends State<WalletBalanceCard> {
  bool _isBalanceVisible = false;

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
                'Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.rotate_left_rounded,
                  color: Colors.white,
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
