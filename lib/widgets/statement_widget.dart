import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/fund_transfer_detail_model.dart';
import '../pages/send_money_success_page.dart';
import '../providers/theme_provider.dart';
import '../services/shared_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StatementWidget extends StatefulWidget {
  final FundTransferModel statement;
  const StatementWidget({
    Key? key,
    required this.statement,
  }) : super(key: key);

  @override
  State<StatementWidget> createState() => _StatementWidgetState();
}

class _StatementWidgetState extends State<StatementWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.statement.cashFlow == 'In' &&
            widget.statement.senderMhichaEmail.isEmpty) {
          return;
        } else if (widget.statement.cashFlow == 'In' &&
            widget.statement.senderMhichaEmail.isNotEmpty) {
          Navigator.pushNamed(
            context,
            SendMoneySuccessPage.routeName,
            arguments: FundTransferModel(
              transactionCode: widget.statement.transactionCode,
              receiverMhichaEmail: SharedService.email,
              receiverUserName: SharedService.userName,
              senderMhichaEmail: widget.statement.senderMhichaEmail,
              senderUserName: widget.statement.senderUserName,
              amount: widget.statement.amount,
              purpose: widget.statement.purpose,
              remarks: widget.statement.remarks,
              time: widget.statement.time,
              cashFlow: widget.statement.cashFlow,
            ),
          );
        } else {
          Navigator.pushNamed(
            context,
            SendMoneySuccessPage.routeName,
            arguments: FundTransferModel(
              transactionCode: widget.statement.transactionCode,
              receiverMhichaEmail: widget.statement.receiverMhichaEmail,
              receiverUserName: widget.statement.receiverMhichaEmail,
              senderMhichaEmail: SharedService.email,
              senderUserName: SharedService.userName,
              amount: widget.statement.amount,
              purpose: widget.statement.purpose,
              remarks: widget.statement.remarks,
              time: widget.statement.time,
              cashFlow: widget.statement.cashFlow,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5,
          ),
          color: Colors.grey.withOpacity(
            0.6,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(
                5,
              ),
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
              child: SizedBox(
                height: 35,
                width: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  child: const Image(
                    image: AssetImage(
                      'images/mhicha.png',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.statement.cashFlow == 'Out'
                        ? 'Fund transferred to ${widget.statement.receiverUserName}'
                        : widget.statement.senderMhichaEmail.isEmpty
                            ? 'Fund received via Load'
                            : 'Fund received from ${widget.statement.senderUserName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  AutoSizeText(
                    widget.statement.time,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.statement.cashFlow == 'In'
                        ? Icons.arrow_drop_down
                        : Icons.arrow_drop_up,
                    color: widget.statement.cashFlow == 'In'
                        ? Colors.green
                        : Colors.red,
                  ),
                  Text(
                    widget.statement.amount.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: widget.statement.cashFlow == 'In'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
