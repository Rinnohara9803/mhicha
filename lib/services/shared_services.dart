import 'package:mhicha/models/fund_transfer_detail_model.dart';

class SharedService {
  static String token = '';
  static String userID = '';
  static String userName = '';
  static String email = '';
  static bool isVerified = false;
  static double balance = 0.0;
  static String sendToUserId = '';
  static String sendToUserName = '';
  static String sendToEmail = '';
  static bool sendToVerified = false;

  static FundTransferModel proceedSendMoney = FundTransferModel(
    transactionCode: '',
    receiverMhichaEmail: '',
    receiverUserName: '',
    senderMhichaEmail: '',
    senderUserName: '',
    amount: 0.0,
    purpose: '',
    remarks: '',
    time: '',
    cashFlow: '',
  );

  static bool isDarkMode = false;
  static bool isNotificationOn = false;
}
