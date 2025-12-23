import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertUpdate {
  static show(
    String title,
    String message,
    String url,
    bool isForceUpdate, {
    Function(bool)? updateAction,
    required BuildContext context,
  }) {
    var message0 = message.replaceAll("\\n", "\n");
    Get.dialog(
      barrierDismissible: !isForceUpdate,
      AlertDialog(
        title: Text(
          textAlign: TextAlign.center,
          title,
        ),
        content: Text(message0),
        actionsAlignment: MainAxisAlignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...!isForceUpdate
                  ? [
                      Flexible(
                        child: AppPrimaryButton(
                          titleStyle: context.myTheme.textThemeT1.button
                              .copyWith(color: Colors.white),
                          buttonColor: Colors.grey,
                          onPressed: () {
                            Get.back();
                            updateAction?.call(false);
                          },
                          title: "Bỏ qua",
                          buttonHeight: 45,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ]
                  : [],
              Flexible(
                child: AppPrimaryButton(
                  titleStyle: context.myTheme.textThemeT1.button
                      .copyWith(color: Colors.white),
                  buttonColor: AppColor.mainColor,
                  onPressed: () async {
                    updateAction?.call(true);
                    try {
                      Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $url';
                      }
                    } catch (e) {}
                  },
                  title: "Cập nhật",
                  buttonHeight: 45,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
