import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ViewQrImageData extends StatefulWidget {
  const ViewQrImageData({
    super.key,
    required this.data,
    required this.nameBloodDonation,
    required this.timeBloodDonation,
    required this.idBloodDonation,
    required this.idRegister,
  });
  final String data;
  final String nameBloodDonation;
  final DateTime timeBloodDonation;
  final String idBloodDonation;
  final String idRegister;

  @override
  State<ViewQrImageData> createState() => _ViewQrImageDataState();
}

class _ViewQrImageDataState extends State<ViewQrImageData> {
  double _previousBrightness = 0.5;
  // final double _previousApplicationBrightness = 0.5;

  @override
  void initState() {
    super.initState();
    // setSystemBrightness(1.0); // Set brightness to 100%
    setApplicationBrightness(1.0);
  }

  Future<double> get systemBrightness async {
    try {
      return await ScreenBrightness.instance.system;
    } catch (e) {
      print(e);
      print('Failed to get system brightness');
    }
    return 0.5;
  }

  Future<void> setSystemBrightness(double brightness) async {
    try {
      _previousBrightness = await systemBrightness;
      await ScreenBrightness.instance.setSystemScreenBrightness(brightness);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<double> get applicationBrightness async {
    try {
      return await ScreenBrightness.instance.application;
    } catch (e) {
      print(e);
      print('Failed to get application brightness');
    }
    return 0.5;
  }

  Future<void> setApplicationBrightness(double brightness) async {
    try {
      await ScreenBrightness.instance
          .setApplicationScreenBrightness(brightness);
    } catch (e) {
      debugPrint(e.toString());
      print('Failed to set application brightness');
    }
  }

  Future<void> resetApplicationBrightness() async {
    try {
      await ScreenBrightness.instance.resetApplicationScreenBrightness();
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to reset application brightness';
    }
  }

  Future<void> _restoreBrightness() async {
    //
    // await setSystemBrightness(_previousBrightness);
    await resetApplicationBrightness();
  }

  @override
  void dispose() {
    _restoreBrightness(); // Restore brightness when exiting
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
            "Mã QR đăng ký hiến máu",
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
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  buildInfo(),
                  const SizedBox(height: 8),
                  QrImageView(
                    data: widget.data,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                    // embeddedImage:
                    //     const AssetImage('assets/icons/app_icon_circle.png'),
                    embeddedImageStyle: const QrEmbeddedImageStyle(
                      size: Size(80, 80),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bloodtype,
                  color: Colors.red), // Icon cho tên đợt hiến máu
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.nameBloodDonation.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  color: Colors.blue), // Icon cho ngày tháng
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Thời gian: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            '${widget.timeBloodDonation.timeHourString} ngày ${widget.timeBloodDonation.ddmmyyyy} (${widget.timeBloodDonation.dayInWeek})', // Giá trị ví dụ
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.tag, color: Colors.green), // Icon cho Id đợt
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Id đợt: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.idBloodDonation, // Giá trị ví dụ
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.tag, color: Colors.green), // Icon cho Id đăng ký
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Id đăng ký: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.idRegister, // Giá trị ví dụ
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
