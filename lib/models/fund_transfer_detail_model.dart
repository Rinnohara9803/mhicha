class FundTransferModel {
  final String transactionCode;
  final String receiverMhichaEmail;
  final String receiverUserName;
  final String senderUserName;
  final String senderMhichaEmail;
  final double amount;
  final String purpose;
  final String remarks;
  final String time;
  final String cashFlow;

  FundTransferModel({
    required this.transactionCode,
    required this.receiverMhichaEmail,
    required this.receiverUserName,
    required this.senderMhichaEmail, 
    required this.senderUserName,
    required this.amount,
    required this.purpose,
    required this.remarks,
    required this.time,
    required this.cashFlow,
  });
}
