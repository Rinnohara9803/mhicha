import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mhicha/models/fund_transfer_detail_model.dart';
import 'package:mhicha/pages/proceed_send_money_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/constants.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mhicha/widgets/general_textformfield.dart';
import 'package:provider/provider.dart';

class SendMoneyPage extends StatefulWidget {
  static String routeName = '/sendMoneyPage';
  const SendMoneyPage({Key? key}) : super(key: key);

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  bool _isLoading = false;
  bool _isBalanceVisible = false;
  final _emailController = TextEditingController();
  final _amountController = TextEditingController();
  final _remarksController = TextEditingController();

  String purpose = '';
  List<String> purposes = [
    'Personal Use',
    'Borrow/Lend',
    'Family Expenses',
    'Bill Sharing',
    'Salary',
    'Others',
  ];

  final _formKey = GlobalKey<FormState>();

  Future<void> fetchSendToUser(String email) async {
    try {
      await AuthService.fetchUserByEmail(email).then((value) {
        SharedService.proceedSendMoney = FundTransferModel(
          transactionCode: DateTime.now().toString(),
          receiverMhichaEmail: SharedService.sendToEmail,
          receiverUserName: SharedService.sendToUserName,
          senderMhichaEmail: SharedService.email,
          senderUserName: SharedService.userName,
          amount: double.parse(_amountController.text),
          purpose: purpose,
          remarks: _remarksController.text,
          time: DateTime.now().toIso8601String(),
          cashFlow: 'Out',
        );
        Navigator.pushNamed(
          context,
          ProceedSendMoneyPage.routeName,
        );
      }).catchError((e) {
        SnackBars.showErrorSnackBar(
          context,
          e.toString(),
        );
      });
    } on SocketException {
      SnackBars.showNoInternetConnectionSnackBar(context);
    } catch (e) {
      SnackBars.showErrorSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<void> saveForm(String email) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await fetchSendToUser(email);
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState!.save();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final isDirectPay = routeArgs['isDirectPay'] as bool;

    final email = routeArgs['email'] as String;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 145,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
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
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(
                          50,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.navigate_before,
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
                        const Spacer(),
                        const AutoSizeText(
                          'Total Balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          if (!isDirectPay)
                            Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                              ),
                              child: TextFormField(
                                enabled: false,
                                initialValue: email,
                                onSaved: (text) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  label: const AutoSizeText(
                                    'Email',
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.mail_outline,
                                  ),
                                ),
                              ),
                            ),
                          if (isDirectPay)
                            Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                              ),
                              child: GeneralTextFormField(
                                hasPrefixIcon: true,
                                hasSuffixIcon: false,
                                controller: _emailController,
                                label: 'Email',
                                validator: (value) {
                                  if (!value!.endsWith('.com') ||
                                      !value.contains('@')) {
                                    return 'Invalid email';
                                  }
                                  if (value.trim().isEmpty) {
                                    return 'Please provide a mhicha email.';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.emailAddress,
                                iconData: Icons.mail_outline,
                                autoFocus: true,
                              ),
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          GeneralTextFormField(
                            hasPrefixIcon: false,
                            hasSuffixIcon: false,
                            controller: _amountController,
                            label: 'Amount',
                            validator: (value) {
                              if (int.tryParse(value!) == null) {
                                return 'Enter valid value';
                              }
                              if (value.isEmpty) {
                                return 'Please specify the amount';
                              }

                              return null;
                            },
                            textInputType: TextInputType.number,
                            iconData: Icons.lock,
                            autoFocus: isDirectPay ? false : true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              isDense: true,
                              border: border,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              errorBorder: errorBorder,
                              focusedBorder: focusedBorder,
                              focusedErrorBorder: focusedErrorBorder,
                              label: const AutoSizeText(
                                'Purpose',
                              ),
                            ),
                            items: purposes.map(
                              (purpose) {
                                return DropdownMenuItem(
                                  child: AutoSizeText(purpose),
                                  value: purpose,
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              purpose = value as String;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a purpose';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GeneralTextFormField(
                            hasPrefixIcon: false,
                            hasSuffixIcon: false,
                            controller: _remarksController,
                            label: 'Remarks',
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please provide a remark.';
                              }
                              return null;
                            },
                            textInputType: TextInputType.name,
                            iconData: Icons.lock,
                            autoFocus: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            child: InkWell(
                              onTap: isDirectPay
                                  ? () async {
                                      await saveForm(_emailController.text);
                                    }
                                  : () async {
                                      await saveForm(email);
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
                                          'Send',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
