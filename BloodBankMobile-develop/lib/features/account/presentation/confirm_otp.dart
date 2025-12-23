import 'dart:async';

import 'package:blood_donation/app/theme/icons.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controller/confirm_otp_controller.dart';

class ConfirmOtp extends StatefulWidget {
  const ConfirmOtp({super.key});

  @override
  State<ConfirmOtp> createState() => _ConfirmOtpState();
}

class _ConfirmOtpState
    extends BaseViewStateful<ConfirmOtp, ConfirmOtpController> {
  @override
  ConfirmOtpController dependencyController() {
    // TODO: implement dependencyController
    return ConfirmOtpController();
  }

  int _secondsRemaining = 120;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> reSendOtp() async {
    ///
    controller.reSendOtp();

    ///
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                )),
            centerTitle: true,
            title: Text(
              "Nhập mã xác thực",
              style: context.myTheme.textThemeT1.title
                  .copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            surfaceTintColor:
                context.myTheme.colorScheme.scaffoldBackgroundColor,
          ),
          body: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                buildContent(context),
                buildImageBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageBottom() {
    return Positioned(
      bottom: 0,
      child: Image.asset(
        AppImages.imgFooter,
        height: 100,
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Positioned.fill(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mã xác thực (6 chữ số) đang gửi đến số điện thoại",
                  textAlign: TextAlign.center,
                  style: context.myTheme.textThemeT1.body
                      .copyWith(color: Colors.black87, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.phoneNumber,
                  textAlign: TextAlign.center,
                  style: context.myTheme.textThemeT1.title
                      .copyWith(color: Colors.black87),
                ),
                const VSpacing(
                  spacing: 30,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    selectedColor: const Color.fromARGB(255, 229, 59, 59),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                  controller: controller.otpController,
                  onCompleted: (value) {
                    controller.onComplete(context);

                    ///
                  },
                  onChanged: (value) {
                    ///
                  },
                  appContext: context,
                ),
                const VSpacing(
                  spacing: 40,
                ),
                _secondsRemaining > 0
                    ? RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Vui lòng chờ ",
                              style: TextStyle(color: Colors.black87),
                            ),
                            TextSpan(
                              text: "$_secondsRemaining'",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 229, 59,
                                    59), // Red color for the number
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: " để yêu cầu gửi lại mã thực",
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          ///resend otp
                          reSendOtp();
                        },
                        child: const Text(
                          "Gửi lại mã",
                          style: TextStyle(
                              color: Color.fromARGB(255, 229, 59, 59),
                              fontSize: 16),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
