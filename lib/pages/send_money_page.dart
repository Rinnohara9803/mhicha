import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mhicha/models/proceed_send_money.dart';
import 'package:mhicha/pages/proceed_send_money_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
    'Personal use',
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
        SharedService.proceedSendMoney = ProceedSendMoney(
          mhichaEmail: SharedService.sendToEmail,
          receiverUserName: SharedService.sendToUserName,
          amount: double.parse(_amountController.text),
          purpose: purpose,
          remarks: _remarksController.text,
        );
        ;
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
                                  label: const Text(
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
                              child: TextFormField(
                                autofocus: true,
                                controller: _emailController,
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
                                onSaved: (text) {
                                  _emailController.text = text!;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.red),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: ThemeClass.primaryColor),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: ThemeClass.primaryColor),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  label: const Text(
                                    'Email',
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.mail_outline,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            autofocus: isDirectPay ? false : true,
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            onSaved: (text) {
                              _amountController.text = text!;
                            },
                            validator: (value) {
                              if (int.tryParse(value!) == null) {
                                return 'Enter valid value';
                              }
                              if (value.isEmpty) {
                                return 'Please specify the amount';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.red),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: ThemeClass.primaryColor),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: ThemeClass.primaryColor),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              label: const Text(
                                'Amount',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.red),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: ThemeClass.primaryColor),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: ThemeClass.primaryColor),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              label: const Text(
                                'Purpose',
                              ),
                            ),
                            items: purposes.map(
                              (purpose) {
                                return DropdownMenuItem(
                                  child: Text(purpose),
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
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _remarksController,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please provide a remark.';
                              }
                              return null;
                            },
                            onSaved: (text) {
                              _remarksController.text = text!;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.red),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: ThemeClass.primaryColor),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: ThemeClass.primaryColor),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              label: const Text(
                                'Remarks',
                              ),
                            ),
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
                                      : const Text(
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
