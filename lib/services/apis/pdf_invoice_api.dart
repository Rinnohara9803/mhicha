import 'dart:io';
import 'package:mhicha/services/apis/pdf_api.dart';
import 'package:pdf/widgets.dart';
import '../../models/student.dart';
import 'package:intl/intl.dart';

class PdfInvoiceApi {
  static Future<File> generate(Student student) async {
    final pdf = Document();

    Widget dataWidget(String key, String value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
          ),
          Text(
            value,
            maxLines: 1,
          ),
        ],
      );
    }

    pdf.addPage(
      MultiPage(
        build: (context) => [
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Send Money',
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm a').format(
                          DateTime.now(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 7,
                        ),
                        child: Text(
                          'Complete',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Rs. 50',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: dataWidget('Channel:', 'GPRS'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: dataWidget('Data:', '_'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: dataWidget('Transaction Code:', 'RINO9803'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: dataWidget(
                            'Processed By:', 'rinnohara9803@gmail.com'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: dataWidget('Is Debit:', 'True'),
                      ),
                      SizedBox(
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
          Divider(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: dataWidget('Purpose:', 'Personal Use'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: dataWidget(
                            'Receiver Username:', 'Swornima Shrestha'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: dataWidget('Email:', 'swornimastha@gmail.com'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: dataWidget('Sender Name:', 'Ajay Prajapti'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: dataWidget('Payment Method:', 'mhicha Ewallet'),
                      ),
                      SizedBox(
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
    );

    return PdfApi.saveDocument(name: 'student1.pdf', pdf: pdf);
  }

  // static Widget buildInvoiceImage(
  //   Student student,
  // ) {
  //   return MemoryImage(
  //     (rootBundle.load('assets/img/your_image.jpg')).buffer.asUint8List(),
  //   );
  // }

  static Widget buildTop(student) => Column(
        children: [
          Text(
            student.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
