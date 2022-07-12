import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mhicha/pages/verify_email_page.dart';
import 'package:mhicha/pages/verify_loadmoneyotp_page.dart';
import 'package:mhicha/services/balance_service.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/circular_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../widgets/general_textformfield.dart';

class LoadMoneyPage extends StatefulWidget {
  static String routeName = '/loadMoneyPage';
  const LoadMoneyPage({Key? key}) : super(key: key);

  @override
  State<LoadMoneyPage> createState() => _LoadMoneyPageState();
}

class _LoadMoneyPageState extends State<LoadMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isBalanceVisible = false;
  bool _isLoading = false;
  final _amountController = TextEditingController();

  Future<void> loadMoneyRequest(double amount) async {
    try {
      await BalanceService.loadBalance(amount).then((value) {
        Navigator.pushNamed(context, VerifyLoadMoneyOtpPage.routeName,
            arguments: SharedService.email);
        SnackBars.showNormalSnackbar(context, 'OTP sent successfully.');
      }).catchError((e) {
        SnackBars.showErrorSnackBar(context, e.toString());
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

  Future<void> saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await loadMoneyRequest(
      double.parse(
        _amountController.text.toString(),
      ),
    );
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
                        top: 40,
                      ),
                      child: Column(
                        children: [
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
                            autoFocus: true,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            child: InkWell(
                              onTap: () async {
                                await saveForm();
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
                                          'Load Money',
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
