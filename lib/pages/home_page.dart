import 'package:flutter/material.dart';
import 'package:mhicha/pages/notifications_page.dart';
import 'package:mhicha/pages/profile_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/statements_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/features_row_widgets.dart';
import 'package:mhicha/widgets/sliding_widgets.dart';
import 'package:mhicha/widgets/wallet_balance_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/statement_widget.dart';

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
          ).getMyProfile().then((_) async {
            await Provider.of<StatementsProvider>(context, listen: false)
                .getStatements('All');
          });
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
                    Expanded(
                      child: InkWell(
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
                                border: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? Border.all(color: Colors.white)
                                    : null,
                              ),
                              child: AutoSizeText(
                                Provider.of<ProfileProvider>(context).userName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
                      'Recent Transactions',
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
                Consumer<StatementsProvider>(
                  builder: (context, statementsData, child) {
                    return statementsData.statements.isEmpty
                        ? const Text(
                            'No statements available!!!.',
                          )
                        : Column(
                            children: statementsData.recentStatements
                                .map((statement) {
                              return StatementWidget(
                                statement: statement,
                              );
                            }).toList(),
                          );
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
