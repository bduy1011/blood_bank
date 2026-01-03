import 'dart:convert';
import 'dart:typed_data';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:blood_donation/utils/smartca_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/colors.dart';
import '../controller/register_donate_blood_controller.dart';

class RegisterDonateBloodPreTestPage extends StatelessWidget {
  const RegisterDonateBloodPreTestPage({
    super.key,
    required this.state,
  });

  final RegisterDonateBloodController state;

  @override
  Widget build(BuildContext context) {
    return _SignaturePageWidget(
      title: AppLocale.preDonationTestTitle.translate(context),
      description: AppLocale.pleaseSignAsStaff.translate(context),
      signatureType: 'staff',
      state: state,
      onSignatureSaved: (signatureBytes) {
        state.staffSignatureBytes = signatureBytes;
        AppUtils.instance.showToast(
          AppLocale.signatureSavedSuccess.translate(context),
        );
        state.updateNextPage(7);
      },
    );
  }
}

class RegisterDonateBloodDoctorPage extends StatelessWidget {
  const RegisterDonateBloodDoctorPage({
    super.key,
    required this.state,
  });

  final RegisterDonateBloodController state;

  @override
  Widget build(BuildContext context) {
    return _SignaturePageWidget(
      title: AppLocale.doctorConfirmationTitle.translate(context),
      description: AppLocale.pleaseSignAsDoctor.translate(context),
      signatureType: 'doctor',
      state: state,
      onSignatureSaved: (signatureBytes) {
        state.doctorSignatureBytes = signatureBytes;
        AppUtils.instance.showToast(
          AppLocale.signatureSavedSuccess.translate(context),
        );
        state.updateNextPage(8);
      },
    );
  }
}

class RegisterDonateBloodNursePage extends StatelessWidget {
  const RegisterDonateBloodNursePage({
    super.key,
    required this.state,
  });

  final RegisterDonateBloodController state;

  @override
  Widget build(BuildContext context) {
    return _SignaturePageWidget(
      title: AppLocale.nurseBloodDrawTitle.translate(context),
      description: AppLocale.pleaseSignAsNurse.translate(context),
      signatureType: 'nurse',
      state: state,
      onSignatureSaved: (signatureBytes) async {
        state.nurseSignatureBytes = signatureBytes;
        AppUtils.instance.showToast(
          AppLocale.signatureSavedSuccess.translate(context),
        );
        await state.completeBloodDonation();
      },
      buttonText: AppLocale.completeBloodDonation.translate(context),
    );
  }
}

class _SignaturePageWidget extends StatefulWidget {
  const _SignaturePageWidget({
    required this.title,
    required this.description,
    required this.signatureType,
    required this.state,
    required this.onSignatureSaved,
    this.buttonText,
  });

  final String title;
  final String description;
  final String signatureType;
  final RegisterDonateBloodController state;
  final Function(Uint8List) onSignatureSaved;
  final String? buttonText;

  @override
  State<_SignaturePageWidget> createState() => _SignaturePageWidgetState();
}

class _SignaturePageWidgetState extends State<_SignaturePageWidget> {
  bool _isSigning = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.mediaQuery.size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20)
            .copyWith(bottom: Get.mediaQuery.padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: context.myTheme.textThemeT1.title.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: context.myTheme.textThemeT1.body.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            // Thông tin về SmartCA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_user, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Chữ ký số SmartCA',
                        style: context.myTheme.textThemeT1.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vui lòng sử dụng chữ ký số SmartCA để xác nhận. '
                    'Chữ ký số sẽ được thực hiện qua hệ thống SmartCA.',
                    style: context.myTheme.textThemeT1.body.copyWith(
                      fontSize: 14,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Nút ký số
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSigning ? null : _signWithSmartCA,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isSigning
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.verified_user,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.buttonText ?? 'Ký số bằng SmartCA',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signWithSmartCA() async {
    setState(() {
      _isSigning = true;
    });

    try {
      // Kiểm tra registration ID
      if (widget.state.registerDonationBlood.id == null ||
          widget.state.registerDonationBlood.id == 0) {
        AppUtils.instance.showToast(
          'Vui lòng đăng ký trước khi ký số.',
        );
        return;
      }

      // Chuẩn bị dữ liệu cần ký
      final dataToSign = SmartCAService.prepareDataForSigning(
        originalData: jsonEncode(widget.state.registerDonationBlood.toJson()),
        metadata: {
          'signatureType': widget.signatureType,
          'registrationId': widget.state.registerDonationBlood.id,
          'step': widget.signatureType,
        },
      );

      // Ký số bằng Web API
      final result = await SmartCAService.signWithWebAPI(
        registrationId: widget.state.registerDonationBlood.id.toString(),
        dataToSign: dataToSign,
        signatureType: widget.signatureType,
      );

      if (result != null && result['success'] == true) {
        // Lưu chữ ký
        widget.onSignatureSaved(result['signature'] as Uint8List);
      } else {
        AppUtils.instance.showToast(
          result?['message'] ?? 'Ký số thất bại',
        );
      }
    } catch (e) {
      AppUtils.instance.showToast(
        "${AppLocale.signatureError.translate(context)} ${e.toString()}",
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSigning = false;
        });
      }
    }
  }
}
