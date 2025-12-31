import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../app/theme/dimens.dart';
import 'button_widget.dart';

class AppDialogInput extends StatelessWidget {
  final String? title;
  final String message;
  final String? buttonTitle;
  final String? labelText;
  final bool? obscureText;
  final Function()? onTap;
  final Function(String)? onChange;

  const AppDialogInput({
    super.key,
    this.title,
    required this.message,
    this.buttonTitle,
    this.onTap,
    this.onChange,
    this.labelText,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = context.myTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimens.buttonRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null) ...{
                Text(
                  '$title',
                  style: myTheme.textThemeT1.bigTitle
                      .copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                )
              },
              const VSpacing(spacing: AppDimens.spacing20),
              Text(
                message,
                style: myTheme.textThemeT1.error.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
                maxLines: 8,
              ),
              const VSpacing(spacing: AppDimens.spacing30),
              _buildTextField(
                context: context,
              ),
              const VSpacing(spacing: AppDimens.spacing30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppPrimaryButton(
                      titleStyle: context.myTheme.textThemeT1.button
                          .copyWith(color: Colors.white),
                      buttonColor: AppColor.mainColor,
                      onPressed: () => Get.back(),
                      title: "Hủy",
                      buttonHeight: 45,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: AppPrimaryButton(
                      titleStyle: context.myTheme.textThemeT1.button
                          .copyWith(color: Colors.white),
                      buttonColor: AppColor.mainColor,
                      onPressed: onTap ?? () => Get.back(),
                      title: buttonTitle ?? AppLocale.close.translate(context),
                      buttonHeight: 45,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({required BuildContext context}) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.3),
            blurStyle: BlurStyle.outer)
      ]),
      child: TextFormField(
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: context.myTheme.textThemeT1.body.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (text) {
          onChange?.call(text);
        },
      ),
    );
  }
}
