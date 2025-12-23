import 'package:blood_donation/app/theme/icons.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState
    extends BaseViewStateful<RegisterPage, RegisterController> {
  @override
  RegisterController dependencyController() {
    // TODO: implement dependencyController
    return RegisterController();
  }

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Đăng ký tài khoản",
            style: context.myTheme.textThemeT1.title.copyWith(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
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
                            maxLength: 100,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(),
                                labelText: "Họ và tên",
                                floatingLabelStyle: context
                                    .myTheme.textThemeT1.title
                                    .copyWith(fontWeight: FontWeight.normal),
                                labelStyle: context.myTheme.textThemeT1.title
                                    .copyWith(fontWeight: FontWeight.normal)),
                            style: context.myTheme.textThemeT1.body
                                .copyWith(fontSize: 16),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: AppLocale.formRequiredNameError
                                    .translate(context),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.usernameRegisterController,
                            maxLength: 12,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(),
                                labelText: "Tên đăng nhập (CCCD/Căn cước)",
                                floatingLabelStyle: context
                                    .myTheme.textThemeT1.title
                                    .copyWith(fontWeight: FontWeight.normal),
                                labelStyle: context.myTheme.textThemeT1.title
                                    .copyWith(fontWeight: FontWeight.normal)),
                            style: context.myTheme.textThemeT1.body
                                .copyWith(fontSize: 16),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: AppLocale.formRequiredUsernameError
                                    .translate(context),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.passwordRegisterController,
                            maxLength: 50,
                            obscureText: !_showPassword,
                            textInputAction: TextInputAction.next,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              labelText: AppLocale.password.translate(context),
                              floatingLabelStyle: context
                                  .myTheme.textThemeT1.title
                                  .copyWith(fontWeight: FontWeight.normal),
                              labelStyle: context.myTheme.textThemeT1.title
                                  .copyWith(fontWeight: FontWeight.normal),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(
                                  !_showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            style: context.myTheme.textThemeT1.body
                                .copyWith(fontSize: 16),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: AppLocale.formRequiredPasswordError
                                      .translate(context)),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller:
                                controller.confirmPasswordRegisterController,
                            maxLength: 50,
                            obscureText: !_showPassword,
                            textInputAction: TextInputAction.done,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              labelText:
                                  AppLocale.confirmPassword.translate(context),
                              floatingLabelStyle: context
                                  .myTheme.textThemeT1.title
                                  .copyWith(fontWeight: FontWeight.normal),
                              labelStyle: context.myTheme.textThemeT1.title
                                  .copyWith(fontWeight: FontWeight.normal),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(
                                  !_showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            style: context.myTheme.textThemeT1.body
                                .copyWith(fontSize: 16),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: AppLocale.formRequiredPasswordError
                                      .translate(context)),
                            ]),
                          ),
                          const VSpacing(
                            spacing: 40,
                          ),
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.register(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 229, 59, 59),
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
              ),
              buildImageBottom(context),
            ],
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
}
