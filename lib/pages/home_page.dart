import 'package:flutter/material.dart';
import 'package:mhicha/pages/notifications_page.dart';
import 'package:mhicha/pages/profile_page.dart';
import 'package:mhicha/pages/send_money_success_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/statements_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/features_row_widgets.dart';
import 'package:mhicha/widgets/sliding_widgets.dart';
import 'package:mhicha/widgets/wallet_balance_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import '../models/fund_transfer_detail_model.dart';
import '../services/shared_services.dart';

class HomePage extends StatefulWidget {
  final Function goToStatementsPage;
  const HomePage({Key? key, required this.goToStatementsPage})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<ProfileProvider>(
            context,
            listen: false,
          ).getMyProfile();
        },
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ProfilePage.routeName);
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 22,
                              left: 5,
                            ),
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 90,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: ThemeClass.primaryColor.withOpacity(
                                0.2,
                              ),
                              border:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? Border.all(color: Colors.white)
                                      : null,
                            ),
                            child: AutoSizeText(
                              Provider.of<ProfileProvider>(context).userName,
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? Colors.white
                                    : ThemeClass.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Positioned(
                            child: CircleAvatar(
                              radius: 39,
                              backgroundColor: Colors.white,
                              child: Hero(
                                tag: 'profileImage',
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'images/profile_avatar.png',
                                  ),
                                  radius: 37,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          NotificationsPage.routeName,
                        );
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: ThemeClass.primaryColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                      flex: 4,
                      child: WalletBalanceCard(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                const FeatureRowWidgets(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      'Transactions',
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.goToStatementsPage();
                      },
                      child: AutoSizeText(
                        'See All',
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : ThemeClass.primaryColor.withOpacity(
                                  0.8,
                                ),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
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
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (statementsData
                                                  .statements[index].cashFlow ==
                                              'In') {
                                            return;
                                          } else {
                                            Navigator.pushNamed(
                                              context,
                                              SendMoneySuccessPage.routeName,
                                              arguments: FundTransferModel(
                                                transactionCode: statementsData
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
                                                        .statements[index].time,
                                                cashFlow: statementsData
                                                    .statements[index].cashFlow,
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
                                            borderRadius: BorderRadius.circular(
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AutoSizeText(
                                                      statementsData
                                                                  .statements[
                                                                      index]
                                                                  .cashFlow ==
                                                              'In'
                                                          ? 'Balance received ${statementsData.statements[index].amount}'
                                                          : 'Fund transferred ${statementsData.statements[index].receiverUserName}',
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      statementsData
                                                                  .statements[
                                                                      index]
                                                                  .cashFlow ==
                                                              'In'
                                                          ? Icons
                                                              .arrow_drop_down
                                                          : Icons.arrow_drop_up,
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
                const SizedBox(
                  height: 20,
                ),
                const Material(
                  elevation: 10,
                  child: SizedBox(
                    height: 190,
                    width: double.infinity,
                    child: SlidingWidgets(),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
