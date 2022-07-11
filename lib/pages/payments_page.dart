import 'package:flutter/material.dart';
import 'package:mhicha/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/student.dart';
import '../services/apis/pdf_api.dart';
import '../services/apis/pdf_invoice_api.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                final pdfFile = await PdfInvoiceApi.generate(
                  Student(
                    firstName: 'Sagar',
                    lastName: 'Prajapati',
                    age: 21,
                  ),
                );
                PdfApi.openFile(pdfFile);
              },
              child: const Text('Generate PDF'),
            ),
            TextButton(
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
          ],
        ),
      ),
    );
  }
}
