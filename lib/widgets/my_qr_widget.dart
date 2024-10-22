import 'package:flutter/material.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'border_painter_widget.dart';

class MyQRWidget extends StatelessWidget {
  const MyQRWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ThemeClass.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      15,
                    ),
                    topRight: Radius.circular(
                      15,
                    ),
                  ),
                ),
                height: 70,
                width: double.infinity,
                child: const Center(
                  child: AutoSizeText(
                    'My QR Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 13,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          // Expanded(
          //   child: Center(
          //     child: CustomPaint(
          //       foregroundPainter: BorderPainter(),
          //       child: Container(
          //         margin: const EdgeInsets.all(
          //           10,
          //         ),
          //         height: MediaQuery.of(context).size.height * 0.25,
          //         width: MediaQuery.of(context).size.height * 0.25,
          //         child: QrImage(
          //           qrCode: SharedService.userID,
          //         ) as Widget,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
