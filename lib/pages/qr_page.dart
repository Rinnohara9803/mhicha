import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mhicha/pages/send_money_page.dart';
import 'package:mhicha/services/auth_service.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:mhicha/utilities/snackbars.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:mhicha/widgets/my_qr_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRPage extends StatefulWidget {
  static String routeName = '/qrPage';
  const QRPage({Key? key}) : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  Barcode? barCode;
  final TextEditingController _userIdController = TextEditingController();
  String userId = '';
  bool qrShowsError = false;

  bool isFlashOn = false;

  Future<void> fetchUser(String userId) async {
    try {
      await AuthService.fetchUser(userId).then(
        (value) {
          Navigator.pushNamed(
            context,
            SendMoneyPage.routeName,
            arguments: {
              'userName': SharedService.sendToUserName,
              'email': SharedService.sendToEmail,
              'isVerified': SharedService.sendToVerified,
            },
          );
        },
      );
    } on SocketException {
      qrShowsError = true;
    } catch (e) {
      qrShowsError = true;
    }
  }

  void onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      this.qrViewController = qrViewController;
    });
    qrViewController.scannedDataStream.listen((barcode) {
      if (qrShowsError) {
        barCode = barCode;
        _userIdController.text = barcode.code.toString();
        fetchUser(_userIdController.text);
        return;
      }
      if (_userIdController.text.isNotEmpty) {
        return;
      }
      barCode = barCode;
      _userIdController.text = barcode.code.toString();
      fetchUser(_userIdController.text);
      return;
    });
  }

  void showQRBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            15,
          ),
          topRight: Radius.circular(
            15,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return const MyQRWidget();
      },
    );
  }

  @override
  void dispose() {
    _userIdController.dispose();
    qrViewController!.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    width: double.infinity,
                    child: QRView(
                      key: _qrKey,
                      onQRViewCreated: onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderRadius: 10,
                        borderLength: 20,
                        borderWidth: 10,
                        borderColor: ThemeClass.primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ThemeClass.primaryColor.withOpacity(0.8),
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My Profile',
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showQRBottomSheet();
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  elevation: 10,
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      color: ThemeClass.primaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.qr_code_scanner_outlined,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'QR Code',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  elevation: 10,
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      color: ThemeClass.primaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.send_to_mobile_sharp,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Send Money',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: FloatingActionButton.small(
                backgroundColor: Colors.grey,
                child: const Icon(
                  Icons.navigate_before,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: isFlashOn
                    ? const Icon(
                        Icons.flash_off,
                        size: 30,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.flash_on,
                        size: 30,
                        color: Colors.white,
                      ),
                onPressed: () async {
                  await qrViewController?.toggleFlash();
                  setState(() {
                    isFlashOn = !isFlashOn;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
