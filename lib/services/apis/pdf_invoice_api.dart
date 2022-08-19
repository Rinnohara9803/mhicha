import 'dart:io';
import 'package:mhicha/models/fund_transfer_detail_model.dart';
import 'package:mhicha/services/apis/pdf_api.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:pdf/widgets.dart';
// import 'package:intl/intl.dart';

class PdfInvoiceApi {
  static Future<File> generate(FundTransferModel psm) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          Expanded(
            flex: 2,
            child: buildTopInvoiceLayout(psm),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            flex: 5,
            child: buildMiddleInvoiceLayout(psm),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            flex: 5,
            child: buildBottomInvoiceLayout(psm),
          ),
        ],
      ),
    );

    return PdfApi.saveDocument(name: '${psm.transactionCode}.pdf', pdf: pdf);
  }

  static Widget buildTopInvoiceLayout(FundTransferModel psm) {
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
                  psm.time,
                ),
                Text(
                  'Complete',
                ),
              ],
            ),
          ),
          Text(
            psm.amount.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildMiddleInvoiceLayout(FundTransferModel psm) {
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
                child: dataWidget('Transaction Code:', psm.transactionCode),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: dataWidget('Processed By:', psm.senderMhichaEmail),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: dataWidget('Cash Flow:', psm.cashFlow),
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

  static buildBottomInvoiceLayout(FundTransferModel psm) {
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
                child: dataWidget('Purpose:', psm.purpose),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: dataWidget(
                  'Receiver Username:',
                  psm.receiverUserName,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: dataWidget('Email:', psm.receiverMhichaEmail),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: dataWidget('Sender Name:', psm.senderUserName),
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
                child: dataWidget('Remarks:', psm.remarks),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
