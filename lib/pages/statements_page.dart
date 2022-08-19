import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mhicha/providers/statements_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/secondary_balance_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mhicha/widgets/statement_widget.dart';
import 'package:provider/provider.dart';

class StatementsPage extends StatefulWidget {
  final Function returnToPreviousFunction;
  const StatementsPage({Key? key, required this.returnToPreviousFunction})
      : super(key: key);

  @override
  State<StatementsPage> createState() => _StatementsPageState();
}

class _StatementsPageState extends State<StatementsPage> {
  var timeFrame = '';
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
                                        var statementTimeFrame = statementsData
                                            .statements[index].time
                                            .toString()
                                            .substring(0, 10);
                                        if (timeFrame != statementTimeFrame) {
                                          timeFrame = statementTimeFrame;
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                statementTimeFrame,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              StatementWidget(
                                                statement: statementsData
                                                    .statements[index],
                                              ),
                                            ],
                                          );
                                        }
                                        return StatementWidget(
                                          statement:
                                              statementsData.statements[index],
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
