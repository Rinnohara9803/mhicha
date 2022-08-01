import 'package:flutter/material.dart';

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
              const Expanded(
                child: Center(
                  child: Text(
                    'No available notifications !!!.',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
