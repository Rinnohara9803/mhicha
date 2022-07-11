import 'package:flutter/material.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SecondaryBalanceCard extends StatefulWidget {
  const SecondaryBalanceCard({Key? key}) : super(key: key);

  @override
  State<SecondaryBalanceCard> createState() => _SecondaryBalanceCardState();
}

class _SecondaryBalanceCardState extends State<SecondaryBalanceCard> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const AutoSizeText(
            'Total Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
