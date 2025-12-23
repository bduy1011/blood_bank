import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../app/theme/dimens.dart';
import 'button_widget.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? buttonTitle;
  final Function()? onTap;
  final bool? isCancel;
  final bool? isAlignmentLeft;

  const AppDialog({
    super.key,
    this.title,
    required this.message,
    this.buttonTitle,
    this.onTap,
    this.isCancel,
    this.isAlignmentLeft,
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
          width: Get.width * 0.9,
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
              Align(
                alignment: isAlignmentLeft == true
                    ? Alignment.centerLeft
                    : Alignment.center,
                child: Text(
                  message,
                  style:
                      myTheme.textThemeT1.error.copyWith(color: Colors.black),
                  textAlign: isAlignmentLeft == true
                      ? TextAlign.start
                      : TextAlign.center,
                  maxLines: 8,
                ),
              ),
              const VSpacing(spacing: AppDimens.spacing40),
              isCancel == true
                  ? Row(
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
                          width: 16,
                        ),
                        Expanded(
                          child: AppPrimaryButton(
                            titleStyle: context.myTheme.textThemeT1.button
                                .copyWith(color: Colors.white),
                            buttonColor: AppColor.mainColor,
                            onPressed: onTap ?? () => Get.back(),
                            title: buttonTitle ?? "Đóng",
                            buttonHeight: 45,
                          ),
                        ),
                      ],
                    )
                  : AppPrimaryButton(
                      titleStyle: context.myTheme.textThemeT1.button
                          .copyWith(color: Colors.white),
                      buttonColor: AppColor.mainColor,
                      onPressed: onTap ?? () => Get.back(),
                      title: buttonTitle ?? "Đóng",
                      buttonHeight: 45,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppOptionalDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? buttonTitle;
  final VoidCallback onPressedBtn;
  final String? altButtonTitle;
  final VoidCallback onPressedAltBtn;

  const AppOptionalDialog({
    super.key,
    this.title,
    required this.message,
    this.buttonTitle,
    this.altButtonTitle,
    required this.onPressedAltBtn,
    required this.onPressedBtn,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = context.myTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimens.spacing40),
          child: Container(
            padding: const EdgeInsets.all(AppDimens.spacing15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimens.buttonRadius)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null) ...{
                  Text(
                    'title!',
                    style: myTheme.textThemeT1.bigTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  )
                },
                const VSpacing(spacing: AppDimens.spacing20),
                Text(
                  message,
                  style: myTheme.textThemeT1.error,
                  textAlign: TextAlign.center,
                  maxLines: 8,
                ),
                const VSpacing(spacing: AppDimens.spacing20),
                const Divider(),
                Row(
                  children: [
                    AppTextButton(
                      style: context.myTheme.buttonThemeT1.button.copyWith(),
                      onPressed: () => onPressedBtn(),
                      title: buttonTitle ?? 'Đồng ý',
                    ),
                    AppTextButton(
                      style: context.myTheme.textThemeT1.button,
                      onPressed: () => onPressedAltBtn(),
                      title: altButtonTitle ?? 'Hủy',
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
