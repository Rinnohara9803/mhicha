import 'dart:convert';
import 'dart:io';
import 'package:mhicha/models/user.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import 'package:http/http.dart' as http;

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
      print(responseData.statusCode);
      var jsonData = jsonDecode(responseData.body);
      print('here');
      print(jsonData);

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {}
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
        Uri.http(Config.authority, 'users/login'),
        headers: headers,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      print(responseData.statusCode);
      var jsonData = jsonDecode(responseData.body);
      print(jsonData);

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', jsonData['token']);
        await prefs.setString('userID', jsonData['userData']['_id']);
        SharedService.token = jsonData['token'];
        SharedService.userID = jsonData['userData']['_id'];
      } else {
        return Future.error(
          'Unauthorized user',
        );
      }
    } on SocketException {
      return Future.error('No Internet Connection');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
