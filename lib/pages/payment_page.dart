import 'package:flutter/material.dart';
import 'package:mhicha/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            flutterLocalNotificationsPlugin.show(
              0,
              'Notification title',
              'Notification body',
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  importance: Importance.high,
                  playSound: true,
                  color: Colors.white,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
            );
          },
          child: const Text(
            'Show Local Notification',
          ),
        ),
      ),
    );
  }
}
