import 'dart:io';
import 'package:mhicha/services/apis/pdf_api.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          Expanded(
            flex: 2,
            child: buildTopInvoiceLayout(),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            flex: 5,
            child: buildMiddleInvoiceLayout(),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            flex: 5,
            child: buildBottomInvoiceLayout(),
          ),
        ],
      ),
    );

    return PdfApi.saveDocument(name: 'invoice1.pdf', pdf: pdf);
  }

  static Widget buildTopInvoiceLayout() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Send Money',
                ),
                Text(
                  DateFormat('yyyy-MM-dd kk:mm a').format(
                    DateTime.now(),
                  ),
                ),
                Text(
                  'Complete',
                ),
              ],
            ),
          ),
          Text(
            'Rs. 50',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildMiddleInvoiceLayout() {
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

    return Container(
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
                child: dataWidget('Processed By:', 'rinnohara9803@gmail.com'),
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
    );
  }

  static buildBottomInvoiceLayout() {
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

    return Container(
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
                child: dataWidget('Receiver Username:', 'Swornima Shrestha'),
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
    );
  }
}
