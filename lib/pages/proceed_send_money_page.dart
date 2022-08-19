import 'package:flutter/material.dart';
import 'package:mhicha/main.dart';
import 'package:mhicha/pages/send_money_success_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/balance_service.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:mhicha/widgets/secondary_balance_card.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/fund_transfer_detail_model.dart';
import '../providers/statements_provider.dart';

class ProceedSendMoneyPage extends StatefulWidget {
  static String routeName = '/proceedSendMoneyPage';
  const ProceedSendMoneyPage({Key? key}) : super(key: key);

  @override
  State<ProceedSendMoneyPage> createState() => _ProceedSendMoneyPageState();
}

class _ProceedSendMoneyPageState extends State<ProceedSendMoneyPage> {
  Widget proceedSendMoneyDetails(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AutoSizeText(
            key,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: AutoSizeText(
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
                  AutoSizeText(
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
              AutoSizeText(
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
              AutoSizeText(
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

  bool _isLoading = false;

  Future<void> confirmSendMoney() async {
    setState(() {
      _isLoading = true;
    });
    await BalanceService.transferBalance(
      FundTransferModel(
        transactionCode: DateTime.now().toString(),
        receiverMhichaEmail: SharedService.proceedSendMoney.receiverMhichaEmail,
        receiverUserName: SharedService.proceedSendMoney.receiverUserName,
        senderMhichaEmail: SharedService.email,
        senderUserName: SharedService.userName,
        amount: SharedService.proceedSendMoney.amount,
        purpose: SharedService.proceedSendMoney.purpose,
        remarks: SharedService.proceedSendMoney.remarks,
        time: DateTime.now().toIso8601String(),
        cashFlow: 'Out',
      ),
    ).then((_) async {
      flutterLocalNotificationsPlugin.show(
        0,
        'Fund transfer',
        'Rs. ${SharedService.proceedSendMoney.amount} transferred to ${SharedService.proceedSendMoney.receiverUserName} successfully !!!',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            playSound: true,
            color: Colors.white,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
      await Provider.of<ProfileProvider>(context, listen: false).getMyProfile();
      await Provider.of<StatementsProvider>(context, listen: false)
          .getStatements();
      Navigator.pushReplacementNamed(
        context,
        SendMoneySuccessPage.routeName,
        arguments: SharedService.proceedSendMoney,
      );
    }).catchError((e) {
      SnackBars.showErrorSnackBar(
        context,
        e.toString(),
      );
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
                            Icons.navigate_before,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const AutoSizeText(
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
                const SecondaryBalanceCard(),
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
                        SharedService.proceedSendMoney.receiverMhichaEmail,
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
                    onTap: () async {
                      await confirmSendMoney();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ThemeClass.primaryColor,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const ProgressIndicator1()
                            : const AutoSizeText(
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
