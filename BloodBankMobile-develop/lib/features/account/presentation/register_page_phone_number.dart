import 'package:blood_donation/app/theme/icons.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../utils/phone_number_formater.dart';
import '../controller/register_controller.dart';

class RegisterPagePhoneNumber extends StatefulWidget {
  const RegisterPagePhoneNumber({super.key});

  @override
  State<RegisterPagePhoneNumber> createState() =>
      _RegisterPagePhoneNumberState();
}

class _RegisterPagePhoneNumberState
    extends BaseViewStateful<RegisterPagePhoneNumber, RegisterController> {
  _RegisterPagePhoneNumberState() : super(isReusable: true);
  @override
  RegisterController dependencyController() {
    // TODO: implement dependencyController
    return RegisterController();
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
              "Đăng ký tài khoản",
              style: context.myTheme.textThemeT1.title
                  .copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            surfaceTintColor:
                context.myTheme.colorScheme.scaffoldBackgroundColor,
          ),
          body: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                buildContent(context),
                buildImageBottom(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageBottom(BuildContext context) {
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
          children: [
            const SizedBox(
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const VSpacing(
                  spacing: 30,
                ),
                TextFormField(
                  controller: controller.fullNameRegisterController,
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
                        controller.registerByPhoneNumber(context);
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
                      child: Text(
                        AppLocale.signUp.translate(context),
                        style: context.myTheme.textThemeT1.title
                            .copyWith(color: Colors.white),
                      )),
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
