// Ví dụ: Cách sử dụng SmartCA thay vì chữ ký tay
// 
// Để sử dụng SmartCA, thay thế code trong register_donate_blood_reception_page.dart
// bằng code tương tự như file này

import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:blood_donation/utils/smartca_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/colors.dart';
import '../controller/register_donate_blood_controller.dart';

class RegisterDonateBloodReceptionPageSmartCA extends StatefulWidget {
  const RegisterDonateBloodReceptionPageSmartCA({
    super.key,
    required this.state,
  });

  final RegisterDonateBloodController state;

  @override
  State<RegisterDonateBloodReceptionPageSmartCA> createState() =>
      _RegisterDonateBloodReceptionPageSmartCAState();
}

class _RegisterDonateBloodReceptionPageSmartCAState
    extends State<RegisterDonateBloodReceptionPageSmartCA> {
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
                    'Vui lòng sử dụng ứng dụng SmartCA để thực hiện chữ ký số.',
                    style: context.myTheme.textThemeT1.body.copyWith(
                      fontSize: 14,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Nút ký số bằng SmartCA
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
                            'Ký số bằng SmartCA',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
            // Nút tải app SmartCA (nếu chưa cài)
            Center(
              child: TextButton(
                onPressed: () {
                  SmartCAService.openSmartCADownload();
                },
                child: Text(
                  'Tải ứng dụng SmartCA',
                  style: context.myTheme.textThemeT1.body.copyWith(
                    color: AppColor.mainColor,
                    decoration: TextDecoration.underline,
                  ),
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
      // Chuẩn bị dữ liệu cần ký
      final dataToSign = SmartCAService.prepareDataForSigning(
        originalData: widget.state.registerDonationBlood.toJson().toString(),
        metadata: {
          'signatureType': 'donor',
          'userId': widget.state.registerDonationBlood.nguoiHienMauId,
          'eventId': widget.state.event?.dotLayMauId,
        },
      );

      // Kiểm tra xem app SmartCA đã cài chưa
      final isInstalled = await SmartCAService.isSmartCAInstalled();
      if (!isInstalled) {
        // Hiển thị dialog yêu cầu cài app
        final shouldInstall = await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Cần cài đặt SmartCA'),
            content: const Text(
              'Để thực hiện chữ ký số, bạn cần cài đặt ứng dụng SmartCA. '
              'Bạn có muốn tải ứng dụng ngay bây giờ không?',
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Tải ngay'),
              ),
            ],
          ),
        );

        if (shouldInstall == true) {
          await SmartCAService.openSmartCADownload();
        }
        return;
      }

      // Ký số bằng Deeplink
      final signatureBytes = await SmartCAService.signWithDeepLink(
        dataToSign: dataToSign,
        signatureType: 'donor',
        reason: 'Ký xác nhận tiếp nhận hiến máu',
        location: widget.state.event?.diaDiemToChuc ?? '',
      );

      if (signatureBytes != null) {
        // Lưu chữ ký
        widget.state.donorSignatureBytes = signatureBytes;
        AppUtils.instance.showToast(
          AppLocale.signatureSavedSuccess.translate(context),
        );
        widget.state.updateNextPage(5);
      } else {
        // Chữ ký chưa hoàn thành (đang chờ callback từ SmartCA)
        // TODO: Implement callback handler để nhận kết quả
        AppUtils.instance.showToast(
          'Đang xử lý chữ ký số. Vui lòng đợi...',
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

