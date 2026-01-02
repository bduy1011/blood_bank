import 'dart:convert';
import 'dart:typed_data';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:blood_donation/utils/smartca_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../app/theme/colors.dart';
import '../controller/register_donate_blood_controller.dart';

class RegisterDonateBloodReceptionPage extends StatefulWidget {
  const RegisterDonateBloodReceptionPage({
    super.key,
    required this.state,
  });

  final RegisterDonateBloodController state;

  @override
  State<RegisterDonateBloodReceptionPage> createState() =>
      _RegisterDonateBloodReceptionPageState();
}

class _RegisterDonateBloodReceptionPageState
    extends State<RegisterDonateBloodReceptionPage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
  );

  bool _useSmartCA = false;
  bool _isSigning = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              AppLocale.receptionStepTitle.translate(context),
              style: context.myTheme.textThemeT1.title.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocale.receptionStepDescription.translate(context),
              style: context.myTheme.textThemeT1.body.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            // Chọn phương thức ký
            _buildSignatureMethodSelector(),
            const SizedBox(height: 24),
            // Hiển thị chữ ký tay hoặc SmartCA
            if (!_useSmartCA) _buildHandSignature() else _buildSmartCASignature(),
            const SizedBox(height: 24),
            // Nút ký
            _buildSignButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignatureMethodSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn phương thức ký:',
            style: context.myTheme.textThemeT1.title.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMethodOption(
                  title: 'Chữ ký tay',
                  icon: Icons.edit,
                  isSelected: !_useSmartCA,
                  onTap: () {
                    setState(() {
                      _useSmartCA = false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMethodOption(
                  title: 'Chữ ký số SmartCA',
                  icon: Icons.verified_user,
                  isSelected: _useSmartCA,
                  onTap: () {
                    setState(() {
                      _useSmartCA = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMethodOption({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.mainColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColor.mainColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColor.mainColor : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: context.myTheme.textThemeT1.body.copyWith(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColor.mainColor : Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandSignature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vui lòng ký tên của bạn vào ô bên dưới',
          style: context.myTheme.textThemeT1.body.copyWith(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Signature(
              controller: _controller,
              height: double.infinity,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _controller.clear();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: AppColor.mainColor,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.refresh,
                      color: AppColor.mainColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocale.clear.translate(context),
                      style: context.myTheme.textThemeT1.title.copyWith(
                        color: AppColor.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmartCASignature() {
    return Container(
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
              Icon(Icons.info_outline, color: Colors.blue[700]),
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
            'Chữ ký số sẽ được thực hiện qua hệ thống SmartCA. '
            'Bạn sẽ được yêu cầu xác thực để hoàn tất quá trình ký số.',
            style: context.myTheme.textThemeT1.body.copyWith(
              fontSize: 14,
              color: Colors.blue[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isSigning ? null : _handleSign,
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
                  Icon(
                    _useSmartCA ? Icons.verified_user : Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _useSmartCA
                        ? 'Ký số bằng SmartCA'
                        : AppLocale.next.translate(context),
                    style: context.myTheme.textThemeT1.title.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  if (!_useSmartCA) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Future<void> _handleSign() async {
    if (_useSmartCA) {
      await _signWithSmartCA();
    } else {
      await _signWithHand();
    }
  }

  Future<void> _signWithHand() async {
    if (_controller.isEmpty) {
      AppUtils.instance.showToast(
        AppLocale.pleaseSignToContinue.translate(context),
      );
      return;
    }

    try {
      final signatureBytes = await _controller.toPngBytes();
      if (signatureBytes != null) {
        widget.state.donorSignatureBytes = signatureBytes;
        AppUtils.instance.showToast(
          AppLocale.signatureSavedSuccess.translate(context),
        );
        widget.state.updateNextPage(5);
      } else {
        AppUtils.instance.showToast(
          AppLocale.cannotSaveSignature.translate(context),
        );
      }
    } catch (e) {
      AppUtils.instance.showToast(
        "${AppLocale.signatureError.translate(context)} ${e.toString()}",
      );
    }
  }

  Future<void> _signWithSmartCA() async {
    setState(() {
      _isSigning = true;
    });

    try {
      // Kiểm tra xem đã có registration ID chưa
      if (widget.state.registerDonationBlood.id == null ||
          widget.state.registerDonationBlood.id == 0) {
        // Nếu chưa đăng ký, cần đăng ký trước
        final response = await widget.state.registerDonateBlood();
        if (response == null) {
          AppUtils.instance.showToast(
            'Vui lòng đăng ký trước khi ký số.',
          );
          return;
        }
      }

      // Chuẩn bị dữ liệu cần ký
      final dataToSign = SmartCAService.prepareDataForSigning(
        originalData: jsonEncode(widget.state.registerDonationBlood.toJson()),
        metadata: {
          'signatureType': 'donor',
          'userId': widget.state.registerDonationBlood.nguoiHienMauId,
          'eventId': widget.state.event?.dotLayMauId,
          'step': 'reception',
        },
      );

      // Ký số bằng Web API
      final result = await SmartCAService.signWithWebAPI(
        registrationId: widget.state.registerDonationBlood.id.toString(),
        dataToSign: dataToSign,
        signatureType: 'donor',
      );

      if (result != null && result['success'] == true) {
        // Lưu chữ ký vào controller
        widget.state.donorSignatureBytes = result['signature'] as Uint8List;
        AppUtils.instance.showToast(
          AppLocale.signatureSavedSuccess.translate(context),
        );
        widget.state.updateNextPage(5);
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
