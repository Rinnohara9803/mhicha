import 'dart:convert';
import 'dart:io';

import 'package:mhicha/models/fund_transfer_detail_model.dart';
import 'package:mhicha/services/shared_services.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class BalanceService {
  static Future<void> loadBalance(double amount) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.post(
        Uri.http(Config.authority, 'api/balance/load-request'),
        headers: headers,
        body: jsonEncode(
          {
            "balanceRequest": amount,
          },
        ),
      );
      var jsonData = jsonDecode(responseData.body);

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        return;
      } else {
        return Future.error(jsonData['error']['message']);
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> validateLoadMoneyOtp(String otp) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.post(
        Uri.http(Config.authority, 'api/balance/load'),
        headers: headers,
        body: jsonEncode(
          {
            "otp": otp,
          },
        ),
      );

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        return;
      } else {
        return Future.error(
          'Something went wrong.',
        );
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> transferBalance(
      FundTransferModel proceedSendMoney) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.post(
        Uri.http(Config.authority, 'api/balance/send'),
        headers: headers,
        body: jsonEncode(
          {
            "email": proceedSendMoney.receiverMhichaEmail,
            "amount": proceedSendMoney.amount,
            "remarks": proceedSendMoney.remarks,
            "purpose": proceedSendMoney.purpose,
          },
        ),
      );

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      } else {
        return Future.error('Insufficient balance !!!');
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
