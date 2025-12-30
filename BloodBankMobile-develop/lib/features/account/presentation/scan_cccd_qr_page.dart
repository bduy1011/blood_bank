import 'dart:developer';
import 'package:blood_donation/models/citizen.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          _errorMessage = "Không thể khởi tạo camera. Vui lòng rebuild app và cấp quyền camera.\nLỗi: $e";
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
          "Lỗi",
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
        "Lỗi",
        "Không thể đọc thông tin từ QR code: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // Khởi động lại scanner để thử lại
      _controller?.start();
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
            "Quét mã QR CCCD/Căn cước",
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
                    "Lỗi camera: ${error.toString()}",
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _initializeScanner();
                    },
                    child: const Text("Thử lại"),
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
                  "Đưa mã QR trên căn cước công dân vào khung",
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
              "Lỗi khởi tạo camera",
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
              child: const Text(
                "Thử lại",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.back(result: null);
              },
              child: const Text("Quay lại"),
            ),
          ],
        ),
      ),
    );
  }
}

