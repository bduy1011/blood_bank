import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../app/theme/dimens.dart';
import '../app_utils.dart';
import '../extension/context_ext.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.color, this.dimension});

  final Color? color;
  final double? dimension;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: dimension ?? AppDimens.icon25,
          child: LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            colors: [
              color ?? context.myTheme.colorScheme.cardColor,
            ],
            strokeWidth: 1,
          ),
        ),
      ],
    );
  }
}

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key, this.message, this.backgroundColor});

  final String? message;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor ?? Colors.grey.withOpacity(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: AppDimens.spacing60,
                    width: AppDimens.spacing80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppDimens.buttonRadius)),
                  ),
                ],
              ),
              const Column(
                children: [
                  SizedBox.square(
                    dimension: AppDimens.icon30,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,
                      colors: [
                        Colors.grey,
                      ],
                      strokeWidth: 2,
                    ),
                  )
                ],
              ),
            ],
          ),
          if (message != null) ...{
            const VSpacing(
              spacing: AppDimens.spacing20,
            ),
            Text(
              message!,
              style: context.myTheme.textThemeT1.light.copyWith(
                  color: context.myTheme.colorScheme.textBtnColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
              textAlign: TextAlign.center,
            )
          },
        ],
      ),
    );
  }
}

class AppLoadingController {
  final params = ValueNotifier<AppLoadingControllerParams>(
    AppLoadingControllerParams(
        visible: false, hasBlurBackground: true, message: null),
  );

  showLoading({bool blurBG = true, String? msg}) {
    params.value = params.value.copyWith(
      visible: true,
      hasBlurBackground: blurBG,
      message: msg,
    );
    EasyLoading.show();
  }

  hideLoading() {
    params.value = params.value.copyWith(visible: false);
    EasyLoading.dismiss();
  }
}

class AppLoadingControllerParams {
  final bool visible;
  final bool hasBlurBackground;
  final String? message;

  AppLoadingControllerParams({
    required this.visible,
    required this.hasBlurBackground,
    required this.message,
  });

  AppLoadingControllerParams copyWith({
    bool? visible,
    bool? hasBlurBackground,
    String? message,
  }) {
    return AppLoadingControllerParams(
      visible: visible ?? this.visible,
      hasBlurBackground: hasBlurBackground ?? this.hasBlurBackground,
      message: message ?? this.message,
    );
  }
}

configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.black
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..textColor = Colors.transparent
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..indicatorWidget =
        AppLoadingHUD(controller: AppUtils.instance.loadingController)
    ..boxShadow = [const BoxShadow(color: Colors.transparent, blurRadius: 10.0)]
    ..userInteractions = false
    ..dismissOnTap = false;
}

class AppLoadingHUD extends StatelessWidget {
  const AppLoadingHUD({super.key, required this.controller});

  final AppLoadingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
            visible: controller.params.value.visible,
            child: AppLoadingWidget(
              message: controller.params.value.message,
            )),
      ],
    );
  }
}
