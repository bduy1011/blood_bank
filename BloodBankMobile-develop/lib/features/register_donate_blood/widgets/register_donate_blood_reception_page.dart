import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/app_utils.dart';
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
            const SizedBox(height: 24),
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
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.next.translate(context),
                          style: context.myTheme.textThemeT1.title.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
