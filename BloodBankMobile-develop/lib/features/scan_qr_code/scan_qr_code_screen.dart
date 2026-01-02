import 'dart:developer';

import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as mobile_scanner;
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
  final mobile_scanner.MobileScannerController _mobileScannerController =
      mobile_scanner.MobileScannerController();
  bool _isDisposed = false;

  @override
  QRController dependencyController() {
    return QRController();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (_isDisposed || qrController == null) return;
    try {
      qrController!.pauseCamera();
      qrController!.resumeCamera();
    } catch (e) {
      log("reassemble()", error: e);
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
          actions: [
            IconButton(
              onPressed: _pickImageFromGallery,
              icon: const Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
              tooltip: AppLocale.selectImageFromGallery.translate(context),
            ),
          ],
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
    if (_isDisposed) {
      controller.dispose();
      return;
    }
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (_isDisposed) return;
      // Xử lý trên microtask để không block main thread
      Future.microtask(() {
        if (_isDisposed) return;
        debugPrint("scanData ${scanData.code}");
        if (hasData(scanData.code) == null) {
          qrController?.pauseCamera();
          onScanQRcode(scanData.code ?? "");
        }
      });
    });
  }

  String? hasData(String? value) {
    if ((value ?? "").contains("|") != true) {
      return 'Please enter card id';
    }
    return null;
  }

  Future<void> onScanQRcode(String data) async {
    try {
      var rs = await widget.onScan.call(data);
      // Đóng trang sau khi xử lý xong, bất kể kết quả
      if (rs == true) {
        Get.back(result: "ok");
      } else {
        Get.back(result: "cancel");
      }
    } catch (e) {
      log("onScanQRcode()", error: e);
      // Đóng trang ngay cả khi có lỗi
      Get.back(result: "cancel");
    }
  }

  /// Chọn ảnh từ thư viện và đọc QR code
  Future<void> _pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image == null) {
        // User đã hủy chọn ảnh
        return;
      }

      // Hiển thị loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final scanResult = await Future.microtask(() async {
        return await _mobileScannerController.analyzeImage(image.path);
      });

      // Đóng loading dialog
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      if (scanResult == null || scanResult.barcodes.isEmpty) {
        Get.snackbar(
          AppLocale.error.translate(context),
          AppLocale.noQRCodeFoundInImage.translate(context),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // Lấy QR code đầu tiên tìm được
      final barcode = scanResult.barcodes.first;
      if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
        // Xử lý QR code giống như scan từ camera
        if (hasData(barcode.rawValue) == null) {
          qrController?.pauseCamera();
          // Gọi onScanQRcode sẽ tự động đóng trang khi thành công
          await onScanQRcode(barcode.rawValue!);
        } else {
          // QR code không hợp lệ, hiển thị thông báo nhưng không đóng trang
          Get.snackbar(
            AppLocale.error.translate(context),
            'Please enter card id',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        Get.snackbar(
          AppLocale.error.translate(context),
          AppLocale.failedToReadQRFromImage.translate(context),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      log("_pickImageFromGallery()", error: e);
      // Đóng loading dialog nếu còn mở
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      Get.snackbar(
        AppLocale.error.translate(context),
        "${AppLocale.failedToReadQRFromImage.translate(context)}: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    // Pause camera trước khi dispose
    qrController?.pauseCamera();
    // Đợi một chút để camera được pause hoàn toàn
    Future.delayed(const Duration(milliseconds: 100), () {
      qrController?.dispose();
    });
    _mobileScannerController.dispose();
    super.dispose();
  }
}
