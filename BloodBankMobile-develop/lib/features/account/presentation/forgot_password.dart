import 'package:blood_donation/app/theme/icons.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../utils/phone_number_formater.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends BaseViewStateful<ForgotPasswordPage, ForgotPasswordController> {
  _ForgotPasswordPageState() : super(isReusable: true);
  @override
  ForgotPasswordController dependencyController() {
    // TODO: implement dependencyController
    return ForgotPasswordController();
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
          resizeToAvoidBottomInset: true,
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
              "Quên mật khẩu",
              style: context.myTheme.textThemeT1.title
                  .copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            surfaceTintColor:
                context.myTheme.colorScheme.scaffoldBackgroundColor,
          ),
          body: Container(
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Stack(
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
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    return Positioned(
      bottom: -20,
      left: 0,
      right: 0,
      child: bottom > 0
          ? const SizedBox.shrink()
          : Image.asset(
              AppImages.imgFooter,
              height: 100,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Positioned.fill(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Vui lòng điền các thông tin bên dưới.\nTrung tâm sẽ liên hệ để cấp lại mật khẩu cho bạn!",
                  textAlign: TextAlign.start,
                  style: context.myTheme.textThemeT1.title
                      .copyWith(color: Colors.black87, fontSize: 16),
                ),
                const VSpacing(
                  spacing: 30,
                ),
                TextFormField(
                  controller: controller.fullNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(),
                      labelText: AppLocale.fullname.translate(context),
                      floatingLabelStyle: context.myTheme.textThemeT1.title
                          .copyWith(fontWeight: FontWeight.normal),
                      labelStyle: context.myTheme.textThemeT1.title
                          .copyWith(fontWeight: FontWeight.normal)),
                  style:
                      context.myTheme.textThemeT1.body.copyWith(fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText:
                            AppLocale.formRequiredNameError.translate(context)),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.idCardController,
                  inputFormatters: [PhoneNumberFormatter()],
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(),
                      labelText: AppLocale.idCard.translate(context),
                      floatingLabelStyle: context.myTheme.textThemeT1.title
                          .copyWith(fontWeight: FontWeight.normal),
                      labelStyle: context.myTheme.textThemeT1.title
                          .copyWith(fontWeight: FontWeight.normal)),
                  style:
                      context.myTheme.textThemeT1.body.copyWith(fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Vui lòng nhập CCCD/Căn cước"),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.phoneController,
                  inputFormatters: [PhoneNumberFormatter()],
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(),
                      labelText: AppLocale.phoneNumber.translate(context),
                      floatingLabelStyle: context.myTheme.textThemeT1.title
                          .copyWith(fontWeight: FontWeight.normal),
                      labelStyle: context.myTheme.textThemeT1.title
                          .copyWith(fontWeight: FontWeight.normal)),
                  style:
                      context.myTheme.textThemeT1.body.copyWith(fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocale.formRequiredPhoneError
                            .translate(context)),
                  ]),
                ),
                const VSpacing(
                  spacing: 40,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.requestForgotPassword(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 229, 59, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 40,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Icon(
                        //   Icons.send,
                        //   color: Colors.white,
                        // ),
                        SvgPicture.asset(
                          "assets/icons/ic_paper-plane.svg",
                          width: 25,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Gửi",
                          style: context.myTheme.textThemeT1.title
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
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
