import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mhicha/config.dart';
import 'package:mhicha/models/fund_transfer_detail_model.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:http/http.dart' as http;

class StatementsProvider with ChangeNotifier {
  List<FundTransferModel> _statements = [];

  List<FundTransferModel> get statements {
    return [..._statements];
  }

  Future<void> getStatements() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.get(
        Uri.http(
          Config.authority,
          'api/balance/get-balance-history',
        ),
        headers: headers,
      );
      var jsonData = jsonDecode(responseData.body);
      List<FundTransferModel> _loadedStatements = [];
      for (var transaction in jsonData) {
        if (transaction['cashFlow'] == 'Out') {
          _loadedStatements.add(
            FundTransferModel(
              transactionCode: transaction['transactionId'],
              receiverMhichaEmail: transaction['receiverEmail'],
              receiverUserName: transaction['receiverName'],
              senderMhichaEmail: SharedService.email,
              senderUserName: SharedService.userName,
              amount: double.parse(transaction['amount'].toString()),
              purpose: transaction['purpose'],
              remarks: transaction['remarks'],
              time: transaction['createdAt'],
              cashFlow: transaction['cashFlow'],
            ),
          );
        } else if (transaction['cashFlow'] == 'In') {
          _loadedStatements.add(
            FundTransferModel(
              transactionCode: transaction['transactionId'],
              receiverMhichaEmail: SharedService.email,
              receiverUserName: SharedService.userName,
              senderMhichaEmail: transaction['senderEmail'] ?? '',
              senderUserName: transaction['senderEmail'] ?? '',
              amount: double.parse(transaction['amount'].toString()),
              purpose: '',
              remarks: '',
              time: '',
              cashFlow: transaction['cashFlow'],
            ),
          );
        }
      }
      _statements = _loadedStatements.reversed.toList();
      notifyListeners();
    } on SocketException {
      return Future.error('No Internet connection');
    } catch (e) {
      return Future.error(
        e.toString(),
      );
    }
  }
}
