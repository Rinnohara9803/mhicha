import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mhicha/models/user.dart';
import 'package:mhicha/pages/dashboard_page.dart';
import 'package:mhicha/pages/sign_in_page.dart';
import 'package:mhicha/pages/verify_email_page.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/statements_provider.dart';

class AuthService {
  static Future<void> signUpUser(User user) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    try {
      var responseData = await http.post(
        Uri.http(Config.authority, 'api/users/signup'),
        headers: headers,
        body: jsonEncode(
          {
            "name": user.userName,
            "email": user.email,
            "password": user.password,
          },
        ),
      );
      var jsonData = jsonDecode(responseData.body);

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        SharedService.userName = jsonData['user']['name'];
        SharedService.email = jsonData['user']['email'];
        SharedService.userID = jsonData['user']['_id'];
        SharedService.token = jsonData['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', jsonData['token']);
        await prefs.setString('userID', jsonData['user']['_id']);
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> signInuser(String email, String password) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    try {
      var responseData = await http.post(
        Uri.http(Config.authority, 'api/users/login'),
        headers: headers,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      var jsonData = jsonDecode(responseData.body);

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        SharedService.userName = jsonData['user']['name'];
        SharedService.email = jsonData['user']['email'];
        SharedService.userID = jsonData['user']['_id'];
        SharedService.isVerified = jsonData['user']['verified'];
        SharedService.token = jsonData['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', jsonData['token']);
        await prefs.setString('userID', jsonData['user']['_id']);
        await prefs.setBool('isVerified', jsonData['user']['verified']);
      } else {
        return Future.error(
          'Invalid email or password',
        );
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> autoLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      Navigator.pushReplacementNamed(context, SignInPage.routeName);
    } else {
      SharedService.token = prefs.getString('token')!;
      SharedService.userID = prefs.getString('userID')!;
      try {
        await Provider.of<ProfileProvider>(context, listen: false)
            .getMyProfile()
            .then((_) {
          Provider.of<StatementsProvider>(context, listen: false)
              .getStatements('All')
              .then((_) {
            if (SharedService.isVerified) {
              Navigator.pushReplacementNamed(context, DashboardPage.routeName);
            } else {
              Navigator.pushReplacementNamed(
                context,
                VerifyEmailPage.routeName,
                arguments: SharedService.email,
              );
            }
          });
        });
      } on SocketException {
        Navigator.pushReplacementNamed(context, SignInPage.routeName);
      } catch (e) {
        Navigator.pushReplacementNamed(context, SignInPage.routeName);
      }
    }
  }

  static Future<void> verifyUser(String otp) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.post(
        Uri.http(Config.authority, 'api/users/verify'),
        headers: headers,
        body: jsonEncode(
          {
            "otp": otp,
          },
        ),
      );

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      } else if (responseData.statusCode == 400) {
        return Future.error('Invalid or expired OTP');
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> resendOtp() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.post(
        Uri.http(Config.authority, 'api/users/resend-otp'),
        headers: headers,
      );

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      } else if (responseData.statusCode == 400) {
        return Future.error('Something went wrong.');
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> fetchUser(String userId) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.get(
        Uri.http(Config.authority, 'api/users/$userId'),
        headers: headers,
      );
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        var jsonData = jsonDecode(responseData.body);
        SharedService.sendToUserId = jsonData['_id'];
        SharedService.sendToUserName = jsonData['name'];
        SharedService.sendToEmail = jsonData['email'];
        SharedService.sendToVerified = jsonData['verified'];
      } else {
        return Future.error('No user found.');
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> fetchUserByEmail(String email) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.get(
        Uri.http(Config.authority, 'api/users/$email'),
        headers: headers,
      );
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        var jsonData = jsonDecode(responseData.body);
        SharedService.sendToUserId = jsonData['_id'];
        SharedService.sendToUserName = jsonData['name'];
        SharedService.sendToEmail = jsonData['email'];
        SharedService.sendToVerified = jsonData['verified'];
      } else {
        return Future.error('No user found.');
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> fetchMyProfile(String userId) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${SharedService.token}",
    };
    try {
      var responseData = await http.get(
        Uri.http(Config.authority, 'api/users/$userId'),
        headers: headers,
      );
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        var jsonData = jsonDecode(responseData.body);
        SharedService.userID = jsonData['_id'];
        SharedService.userName = jsonData['name'];
        SharedService.email = jsonData['email'];
        SharedService.isVerified = jsonData['verified'];
      } else {
        return Future.error('No user found.');
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(
      context,
      SignInPage.routeName,
    );
  }
}
