import 'package:flutter/material.dart';
import 'package:mhicha/pages/profile_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/features_row_widgets.dart';
import 'package:mhicha/widgets/sliding_widgets.dart';
import 'package:mhicha/widgets/wallet_balance_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                          ),
                          child: Text(
                            Provider.of<ProfileProvider>(context).userName,
                            style: TextStyle(
                              color: ThemeClass.primaryColor,
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
                    onPressed: () {},
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
                  const Text(
                    'Transactions',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: ThemeClass.primaryColor.withOpacity(
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
              const Text(
                'You have no available transactions !!!',
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
    );
  }
}
