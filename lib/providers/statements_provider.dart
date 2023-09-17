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

  List<FundTransferModel> _recentStatements = [];

  List<FundTransferModel> get recentStatements {
    return [..._recentStatements];
  }

  Future<void> getStatements(String filterBy) async {
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
      if (responseData.statusCode == 204) {
        _statements = [];
        notifyListeners();
        _recentStatements = [];
        notifyListeners();
        return;
      }

      var jsonData = jsonDecode(responseData.body);
      List<FundTransferModel> _loadedStatements = [];

      if (responseData.statusCode == 401) {
        return Future.error('Something went wrong.');
      }
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
              senderUserName: transaction['senderName'] ?? '',
              amount: double.parse(transaction['amount'].toString()),
              purpose: transaction['purpose'],
              remarks: transaction['remarks'],
              time: transaction['createdAt'],
              cashFlow: transaction['cashFlow'],
            ),
          );
        }
      }
      if (filterBy == 'All') {
        _statements = _loadedStatements.reversed.toList();
        notifyListeners();
      } else if (filterBy == 'Debit') {
        _statements = _loadedStatements.reversed
            .where((statement) => statement.cashFlow == 'In')
            .toList();
        notifyListeners();
      } else if (filterBy == 'Credit') {
        _statements = _loadedStatements.reversed
            .where((statement) => statement.cashFlow == 'Out')
            .toList();
        notifyListeners();
      }

      _recentStatements = _loadedStatements.reversed.take(3).toList();
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
