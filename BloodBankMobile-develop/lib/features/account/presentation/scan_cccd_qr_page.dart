import 'dart:developer';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/models/citizen.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCCCDQRPage extends StatefulWidget {
  const ScanCCCDQRPage({super.key});

  @override
  State<ScanCCCDQRPage> createState() => _ScanCCCDQRPageState();
}

class _ScanCCCDQRPageState extends State<ScanCCCDQRPage> {
  MobileScannerController? _controller;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
  }

  void _initializeScanner() async {
    try {
      _controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        autoStart: false, // Không auto start, sẽ start sau khi có quyền
      );
      
      // MobileScanner sẽ tự xin quyền camera khi start
      await _controller?.start();
      
      if (mounted) {
        setState(() {
          _hasError = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      log("_initializeScanner()", error: e);
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = "${AppLocale.cannotInitCamera.translate(context)} $e";
        });
      }
    }
  }

  void _handleQRCode(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return;
    
    // Tạm dừng scanner để tránh scan nhiều lần
    _controller?.stop();

    try {
      // Parse QR code thành Citizen model
      final citizen = Citizen.fromQRCode(rawValue);

      // Validate thông tin
      if (!citizen.isValid()) {
        final errors = citizen.getValidationErrors();
        Get.snackbar(
          AppLocale.error.translate(context),
          errors.join("\n"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        // Khởi động lại scanner để thử lại
        _controller?.start();
        return;
      }

      // Trả về kết quả
      Get.back(result: citizen);
    } catch (e) {
      log("_handleQRCode()", error: e);
      Get.snackbar(
        AppLocale.error.translate(context),
        "${AppLocale.cannotReadQRCode.translate(context)} $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // Khởi động lại scanner để thử lại
      _controller?.start();
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

      // Đọc QR code từ ảnh bằng mobile_scanner
      final result = await _controller?.analyzeImage(image.path);

      // Đóng loading dialog
      Get.back();

      if (result == null || result.barcodes.isEmpty) {
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
      final barcode = result.barcodes.first;
      if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
        _handleQRCode(barcode.rawValue);
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
    _controller?.dispose();
    super.dispose();
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
            AppLocale.scanQRCCCD.translate(context),
            style: context.myTheme.textThemeT1.title.copyWith(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back(result: null);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
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
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: _hasError
              ? _buildErrorView()
              : _buildScannerView(),
        ),
      ),
    );
  }

  Widget _buildScannerView() {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        MobileScanner(
          controller: _controller!,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (barcode.rawValue != null) {
                _handleQRCode(barcode.rawValue);
                break;
              }
            }
          },
          errorBuilder: (context, error, child) {
            log("MobileScanner error: $error");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    "${AppLocale.cameraError.translate(context)}: ${error.toString()}",
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _initializeScanner();
                    },
                    child: Text(AppLocale.tryAgain.translate(context)),
                  ),
                ],
              ),
            );
          },
        ),
        // Overlay hướng dẫn
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocale.qrScanInstruction.translate(context),
                  style: context.myTheme.textThemeT1.body.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocale.cameraInitError.translate(context),
              style: context.myTheme.textThemeT1.title.copyWith(
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: context.myTheme.textThemeT1.body.copyWith(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _initializeScanner();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 59, 59),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: Text(
                AppLocale.tryAgain.translate(context),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.back(result: null);
              },
              child: Text(AppLocale.back.translate(context)),
            ),
          ],
        ),
      ),
    );
  }
}

