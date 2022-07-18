import 'package:flutter/material.dart';
import 'package:mhicha/utilities/themes.dart';

class NotificationsPage extends StatefulWidget {
  static String routeName = '/notificationsPage';
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          width: MediaQuery.of(context).size.width,
          child: Column(
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
                  const Text(
                    'My Notifications',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: const Color(0xff018AF3).withOpacity(
                            0.7,
                          ),
                        ),
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.notifications_active_outlined,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Topic',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Description is this that in the townr ekjldfjs kdjfkdfjdjkfj fkjdkfjdjfjdk k fklsdjfksdljfjkldsjkfjskldjkfsdlfjdklf',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
