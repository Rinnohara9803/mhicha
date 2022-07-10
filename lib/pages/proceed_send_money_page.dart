import 'package:flutter/material.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';

class ProceedSendMoneyPage extends StatefulWidget {
  static String routeName = '/proceedSendMoneyPage';
  const ProceedSendMoneyPage({Key? key}) : super(key: key);

  @override
  State<ProceedSendMoneyPage> createState() => _ProceedSendMoneyPageState();
}

class _ProceedSendMoneyPageState extends State<ProceedSendMoneyPage> {
  bool _isBalanceVisible = true;

  Widget proceedSendMoneyDetails(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            key,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  String name = 'Ajay';

  List userNameChars =
      SharedService.proceedSendMoney.receiverUserName.split(' ');

  String hashedReceiverUserName() {
    List toBeHashedUserName = userNameChars[0].split("");
    List uniqueToBeHashedUserName = [];
    String hashedUserName = '';

    for (var i in toBeHashedUserName) {
      uniqueToBeHashedUserName.add({
        'key': UniqueKey(),
        'value': i,
      });
    }

    for (var i in uniqueToBeHashedUserName) {
      if (uniqueToBeHashedUserName.indexOf(i) <= 1 ||
          uniqueToBeHashedUserName.indexOf(i) ==
              uniqueToBeHashedUserName.length - 1) {
        hashedUserName = hashedUserName + i['value'];
      } else {
        hashedUserName = hashedUserName + "*";
      }
    }

    userNameChars[0] = hashedUserName;

    return userNameChars.join(" ");
  }

  void showNoticeBottomSheet() {
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
                    Icons.info,
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Notice',
                    style: TextStyle(
                      fontSize: 20,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Please send money to only Trusted users after verifying properly. Do not send money on request from facebook, messenger or other social networking sites.',
                style: TextStyle(
                  fontSize: 14,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'OR Call to confirm before sending money to any person in mhicha.',
                style: TextStyle(
                  fontSize: 14,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(
              8,
            ),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Send Money',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showNoticeBottomSheet();
                      },
                      icon: Icon(
                        Icons.info,
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
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
                            child: Text(
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
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20,
                  ),
                  width: double.infinity,
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
                    children: [
                      proceedSendMoneyDetails(
                        'Email',
                        SharedService.proceedSendMoney.mhichaEmail,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      proceedSendMoneyDetails(
                        'Receiver Username',
                        hashedReceiverUserName(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      proceedSendMoneyDetails(
                        'Amount ( NPR ) ',
                        SharedService.proceedSendMoney.amount.toString(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      proceedSendMoneyDetails(
                        'Purpose',
                        SharedService.proceedSendMoney.purpose,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      proceedSendMoneyDetails(
                        'Remarks',
                        SharedService.proceedSendMoney.remarks,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ThemeClass.primaryColor,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Confirm',
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
      ),
    );
  }
}
