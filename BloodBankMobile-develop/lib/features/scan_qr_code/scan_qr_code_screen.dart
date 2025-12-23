import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../base/base_view/base_view.dart';

class QRController extends BaseModelStateful {
  @override
  void onBack() {
    // TODO: implement onBack
    Get.back();
  }

  @override
  void onTapRightMenu() {
    // TODO: implement onTapRightMenu
  }
}

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({
    super.key,
    required this.onScan,
    required this.title,
  });

  final String title;
  final Future<bool> Function(String url) onScan;

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState
    extends BaseViewStateful<ScanQrCodeScreen, QRController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;

  @override
  QRController dependencyController() {
    return QRController();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (qrController != null) {
      qrController!.pauseCamera();
      qrController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFB22C2D),
            Color.fromARGB(255, 240, 88, 88),
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: context.myTheme.textThemeT1.title.copyWith(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      debugPrint("scanData ${scanData.code}");
      if (hasData(scanData.code) == null) {
        //
        qrController?.pauseCamera();
        onScanQRcode(scanData.code ?? "");
      }
    });
  }

  String? hasData(String? value) {
    if ((value ?? "").contains("|") != true) {
      return 'Please enter card id';
    }
    return null;
  }

  Future<void> onScanQRcode(String data) async {
    var rs = await widget.onScan.call(data);
    if (rs == true) {
      Get.back(result: "ok");
    } else {
      Get.back(result: "cancel");
    }
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
