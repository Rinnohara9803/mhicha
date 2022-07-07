import 'package:mhicha/models/proceed_send_money.dart';

class SharedService {
  static String token = '';
  static String userID = '';
  static String userName = '';
  static String email = '';
  static bool isVerified = false;
  static String sendToUserId = '';
  static String sendToUserName = '';
  static String sendToEmail = '';
  static bool sendToVerified = false;
  static ProceedSendMoney proceedSendMoney = ProceedSendMoney(
    mhichaEmail: '',
    receiverUserName: '',
    amount: 0.0,
    purpose: '',
    remarks: '',
  );
}
