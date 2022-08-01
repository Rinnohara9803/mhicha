import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mhicha/models/fund_transfer_detail_model.dart';
import 'package:mhicha/pages/send_money_success_page.dart';
import 'package:mhicha/providers/statements_provider.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/secondary_balance_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class StatementsPage extends StatefulWidget {
  final Function returnToPreviousFunction;
  const StatementsPage({Key? key, required this.returnToPreviousFunction})
      : super(key: key);

  @override
  State<StatementsPage> createState() => _StatementsPageState();
}

class _StatementsPageState extends State<StatementsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.returnToPreviousFunction();
                    },
                    icon: const Icon(
                      Icons.navigate_before,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const AutoSizeText(
                    'Statements',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(
                  10,
                ),
                child: const SecondaryBalanceCard(),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: FutureBuilder(
                    future:
                        Provider.of<StatementsProvider>(context, listen: false)
                            .getStatements(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: ThemeClass.primaryColor,
                              strokeWidth: 2.0,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.error.toString(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {});
                                },
                                child: const Text(
                                  'Try Again',
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Consumer<StatementsProvider>(
                          builder: (context, statementsData, child) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await statementsData.getStatements();
                              },
                              child: statementsData.statements.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No statements available!!!.',
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          statementsData.statements.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            if (statementsData.statements[index]
                                                    .cashFlow ==
                                                'In') {
                                              return;
                                            } else {
                                              Navigator.pushNamed(
                                                context,
                                                SendMoneySuccessPage.routeName,
                                                arguments: FundTransferModel(
                                                  transactionCode:
                                                      statementsData
                                                          .statements[index]
                                                          .transactionCode,
                                                  receiverMhichaEmail: statementsData
                                                                  .statements[
                                                                      index]
                                                                  .cashFlow ==
                                                              'In' &&
                                                          statementsData
                                                              .statements[index]
                                                              .senderMhichaEmail
                                                              .isNotEmpty
                                                      ? SharedService.email
                                                      : statementsData
                                                          .statements[index]
                                                          .receiverMhichaEmail,
                                                  receiverUserName: statementsData
                                                                  .statements[
                                                                      index]
                                                                  .cashFlow ==
                                                              'In' &&
                                                          statementsData
                                                              .statements[index]
                                                              .senderMhichaEmail
                                                              .isNotEmpty
                                                      ? SharedService.userName
                                                      : statementsData
                                                          .statements[index]
                                                          .receiverMhichaEmail,
                                                  senderMhichaEmail: 'rino',
                                                  senderUserName: 'rino',
                                                  amount: statementsData
                                                      .statements[index].amount,
                                                  purpose: statementsData
                                                                  .statements[
                                                                      index]
                                                                  .cashFlow ==
                                                              'In' &&
                                                          statementsData
                                                              .statements[index]
                                                              .senderMhichaEmail
                                                              .isEmpty
                                                      ? ''
                                                      : statementsData
                                                          .statements[index]
                                                          .purpose,
                                                  remarks: statementsData
                                                                  .statements[
                                                                      index]
                                                                  .cashFlow ==
                                                              'In' &&
                                                          statementsData
                                                              .statements[index]
                                                              .senderMhichaEmail
                                                              .isEmpty
                                                      ? ''
                                                      : statementsData
                                                          .statements[index]
                                                          .remarks,
                                                  time: statementsData
                                                      .statements[index].time,
                                                  cashFlow: statementsData
                                                      .statements[index]
                                                      .cashFlow,
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 10,
                                            ),
                                            margin: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5,
                                              ),
                                              color: Colors.grey.withOpacity(
                                                0.6,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                DottedBorder(
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(
                                                    5,
                                                  ),
                                                  color:
                                                      Provider.of<ThemeProvider>(
                                                                  context)
                                                              .isDarkMode
                                                          ? Colors.white
                                                          : Colors.black,
                                                  child: SizedBox(
                                                    height: 35,
                                                    width: 35,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        15,
                                                      ),
                                                      child: const Image(
                                                        image: AssetImage(
                                                          'images/mhicha.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AutoSizeText(
                                                        statementsData
                                                                    .statements[
                                                                        index]
                                                                    .cashFlow ==
                                                                'In'
                                                            ? 'Balance received ${statementsData.statements[index].amount}'
                                                            : 'Fund transferred to ${statementsData.statements[index].receiverUserName}',
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                      AutoSizeText(
                                                        statementsData
                                                            .statements[index]
                                                            .time,
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        statementsData
                                                                    .statements[
                                                                        index]
                                                                    .cashFlow ==
                                                                'In'
                                                            ? Icons
                                                                .arrow_drop_down
                                                            : Icons
                                                                .arrow_drop_up,
                                                        color: statementsData
                                                                    .statements[
                                                                        index]
                                                                    .cashFlow ==
                                                                'In'
                                                            ? Colors.green
                                                            : Colors.red,
                                                      ),
                                                      Text(
                                                        '200.0',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: statementsData
                                                                      .statements[
                                                                          index]
                                                                      .cashFlow ==
                                                                  'In'
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            );
                          },
                        );
                      }
                    },
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
