import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mhicha/services/shared_services.dart';

import '../config.dart';

class ProfileProvider with ChangeNotifier {
  String _userName = SharedService.userName;
  String _email = SharedService.email;

  // void setProfileDetails(String userName, String email) {
  //   _userName = userName;
  //   notifyListeners();
  //   _email = email;
  //   notifyListeners();
  // }

  String get userName {
    return _userName;
  }

  String get email {
    return _email;
  }

  Future<void> updateProfile(String userName, String email) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      await http
          .put(
        Uri.http(Config.authority, 'user'),
        headers: headers,
        body: jsonEncode(
          {
            'name': userName,
            'email': email,
          },
        ),
      )
          .then((_) {
        _userName = userName;
        notifyListeners();
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
        Uri.http(Config.authority, 'users/me'),
        headers: headers,
      );

      var jsonData = jsonDecode(responseData.body);

      SharedService.userID = jsonData['_id'];
      SharedService.userName = jsonData['name'];
      SharedService.email = jsonData['email'];
      SharedService.isVerified = jsonData['verified'];

      _userName = SharedService.userName;
      _email = SharedService.email;
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
