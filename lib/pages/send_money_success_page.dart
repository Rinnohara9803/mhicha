import 'package:flutter/material.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/services/apis/pdf_api.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/secondary_balance_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import '../services/apis/pdf_invoice_api.dart';
import 'package:share/share.dart';

class SendMoneySuccessPage extends StatelessWidget {
  static String routeName = '/sendMoneySuccessPage';
  const SendMoneySuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPdfDownloaded = false;
    Widget dataWidget(String key, String value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            key,
          ),
          AutoSizeText(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 30,
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
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.navigate_before,
                        ),
                      ),
                      const AutoSizeText(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final pdfFile = await PdfInvoiceApi.generate();
                          Share.shareFiles(
                            [pdfFile.path],
                          );
                        },
                        icon: const Icon(
                          Icons.share,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (isPdfDownloaded) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Are you Sure ?'),
                                    content: const Text(
                                      'Do you want to re-download the Pdf ?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'No',
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          final pdfFile =
                                              await PdfInvoiceApi.generate();
                                          PdfApi.openFile(pdfFile);
                                          isPdfDownloaded = true;
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                });
                            return;
                          } else {
                            final pdfFile = await PdfInvoiceApi.generate();
                            PdfApi.openFile(pdfFile);
                            isPdfDownloaded = true;
                          }
                        },
                        icon: const Icon(Icons.picture_as_pdf_outlined),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SecondaryBalanceCard(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    15,
                  ),
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const AutoSizeText(
                                      'Send Money',
                                    ),
                                    AutoSizeText(
                                      DateFormat('yyyy-MM-dd – kk:mm a').format(
                                        DateTime.now(),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 7,
                                      ),
                                      color: ThemeClass.primaryColor,
                                      child: const AutoSizeText(
                                        'Complete',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const AutoSizeText(
                                  'Rs. 50',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: dataWidget('Channel:', 'GPRS'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: dataWidget('Data:', '_'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: dataWidget(
                                          'Transaction Code:', 'RINO9803'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: dataWidget('Processed By:',
                                          'rinnohara9803@gmail.com'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: dataWidget('Is Debit:', 'True'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: dataWidget('', ''),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: dataWidget(
                                          'Purpose:', 'Personal Use'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: dataWidget('Receiver Username:',
                                          'Swornima Shrestha'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: dataWidget(
                                          'Email:', 'swornimastha@gmail.com'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: dataWidget(
                                          'Sender Name:', 'Ajay Prajapti'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: dataWidget(
                                          'Payment Method:', 'mhicha Ewallet'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: dataWidget('Remarks:', 'due'),
                                    ),
                                  ],
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
              const SizedBox(
                height: 10,
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
                      child: AutoSizeText(
                        'Finish',
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
    );
  }
}
