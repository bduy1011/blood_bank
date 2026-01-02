import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/colors.dart';
import '../controller/register_donate_blood_controller.dart';

class RegisterDonateBloodVitalSignsPage extends StatelessWidget {
  const RegisterDonateBloodVitalSignsPage({
    super.key,
    required this.state,
  });

  final RegisterDonateBloodController state;

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
              AppLocale.measureVitalSignsTitle.translate(context),
              style: context.myTheme.textThemeT1.title.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              context: context,
              label: '${AppLocale.bloodPressure.translate(context)} (${AppLocale.systolic.translate(context)})',
              controller: state.systolicController,
              keyboardType: TextInputType.number,
              hint: '120',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context: context,
              label: '${AppLocale.bloodPressure.translate(context)} (${AppLocale.diastolic.translate(context)})',
              controller: state.diastolicController,
              keyboardType: TextInputType.number,
              hint: '80',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context: context,
              label: '${AppLocale.heartRate.translate(context)} (${AppLocale.bpm.translate(context)})',
              controller: state.heartRateController,
              keyboardType: TextInputType.number,
              hint: '72',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context: context,
              label: '${AppLocale.temperature.translate(context)} (${AppLocale.celsius.translate(context)})',
              controller: state.temperatureController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              hint: '36.5',
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (state.systolicController.text.isEmpty ||
                      state.diastolicController.text.isEmpty ||
                      state.heartRateController.text.isEmpty ||
                      state.temperatureController.text.isEmpty) {
                    Get.snackbar(
                      AppLocale.notificationTitle.translate(context),
                      AppLocale.pleaseEnterVitalSigns.translate(context),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  // After vital signs, go to pre-test page (page 6)
                  state.updateNextPage(6);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  AppLocale.next.translate(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.myTheme.textThemeT1.body.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColor.mainColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}

