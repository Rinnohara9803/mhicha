import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mhicha/services/shared_services.dart';

import '../config.dart';

class ProfileProvider with ChangeNotifier {
  String _userName = SharedService.userName;
  String _email = SharedService.email;
  double _balance = SharedService.balance;

  String get userName {
    return _userName;
  }

  String get email {
    return _email;
  }

  double get balance {
    return _balance;
  }

  Future<void> updateProfile(String userName, String email) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      await http
          .put(
        Uri.http(Config.authority, 'api/users/${SharedService.userID}'),
        headers: headers,
        body: jsonEncode(
          {
            'name': userName,
            'email': email,
          },
        ),
      )
          .then((_) {
        SharedService.userName = userName;
        _userName = userName;

        notifyListeners();
        SharedService.email = email;
        _email = email;
        notifyListeners();
      });
    } on SocketException {
      return Future.error('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getMyProfile() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.get(
        Uri.http(Config.authority, 'api/users/me'),
        headers: headers,
      );

      var jsonData = jsonDecode(responseData.body);

      SharedService.userID = jsonData['_id'];
      SharedService.userName = jsonData['name'];
      SharedService.email = jsonData['email'];
      SharedService.isVerified = jsonData['verified'];
      SharedService.balance = double.parse(
        jsonData['balance'].toString(),
      );

      _userName = SharedService.userName;
      notifyListeners();
      _email = SharedService.email;
      notifyListeners();
      _balance = SharedService.balance;
      notifyListeners();
    } on SocketException {
      return Future.error('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> createNewPassword(String newPassword) async {
  //   Map<String, String> headers = {
  //     "Content-type": "application/json",
  //     "Authorization": "Bearer ${SharedService.token}",
  //   };
  //   try {
  //     await http.put(
  //       Uri.http(Config.authority, 'user/updatepassword'),
  //       headers: headers,
  //       body: jsonEncode(
  //         {
  //           'Password': newPassword,
  //         },
  //       ),
  //     );
  //   } on SocketException {
  //     return Future.error('No Internet connection');
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
