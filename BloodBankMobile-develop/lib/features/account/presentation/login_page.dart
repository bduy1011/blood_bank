import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/app/theme/icons.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/question_answer/presentation/question_answer_page.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:blood_donation/utils/biometric_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../about/presentation/contact_page.dart';
import '../controller/login_controller.dart';
import 'forgot_password.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseViewStateful<LoginPage, LoginController> {
  @override
  LoginController dependencyController() {
    // TODO: implement dependencyController
    return LoginController();
  }

  bool _showPassword = false;
  bool _biometricAvailable = false;
  String _biometricTypeName = 'Biometric';
  final BiometricAuthService _biometricAuthService = BiometricAuthService();

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
    // Tự động đăng nhập bằng biometric nếu có tokens đã lưu
    _checkAndAutoLogin();
  }

  Future<void> _checkBiometricAvailability() async {
    final isAvailable = await _biometricAuthService.isAvailable();
    final biometricTypeName = await _biometricAuthService.getBiometricTypeName();
    setState(() {
      _biometricAvailable = isAvailable;
      _biometricTypeName = biometricTypeName;
    });
  }

  Future<void> _checkAndAutoLogin() async {
    final hasTokens = await controller.hasStoredTokens();
    if (hasTokens) {
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.checkAndAutoLoginWithBiometric(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildIcon(),
                          const VSpacing(
                            spacing: 30,
                          ),
                          buildUserName(context),
                          const SizedBox(
                            height: 20,
                          ),
                          buildPassword(context),
                          const VSpacing(
                            spacing: 40,
                          ),
                          buildButtonLogin(context),
                          if (_biometricAvailable) ...[
                            const SizedBox(height: 20),
                            buildBiometricLoginButton(context),
                          ],
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Positioned buildBottomSection(BuildContext context) {
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

  Widget buildAction(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            buildActionRegister(context),
            const Spacer(),
            buildActionQA(context),
            const Spacer(),
            buildActionContact(context),
          ],
        ),
        buildActionForgotPassword(context),
      ],
    );
  }

  TextButton buildActionForgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(const ForgotPasswordPage());
        // Get.to(() => const RegisterPagePhoneNumber());
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        // padding: EdgeInsets.zero,
        // backgroundColor: Colors.red,
      ),
      child: Text(
        AppLocale.forgotPassword.translate(context),
        style: context.myTheme.textThemeT1.title
            .copyWith(color: AppColor.grey, fontSize: 16),
      ),
    );
  }

  TextButton buildActionRegister(BuildContext context) {
    return TextButton(
      onPressed: () async {
        var rs = await Get.to(() => const RegisterPage());
        if (rs == true) {
          controller.initUserName();
        }
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        // padding: EdgeInsets.zero,
        // backgroundColor: Colors.red,
      ),
      child: Text(
        AppLocale.signUp.translate(context),
        style: context.myTheme.textThemeT1.title
            .copyWith(color: AppColor.mainColor, fontSize: 16),
      ),
    );
  }

  TextButton buildActionQA(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(() => const QuestionAnswerPage());
        // Get.to(() => const RegisterPagePhoneNumber());
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        // padding: EdgeInsets.zero,
        // backgroundColor: Colors.red,
      ),
      child: Text(
        AppLocale.questionAndAnswer.translate(context),
        style: context.myTheme.textThemeT1.title
            .copyWith(color: AppColor.mainColor, fontSize: 16),
      ),
    );
  }

  TextButton buildActionContact(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(() => const ContactPage());
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        // padding: EdgeInsets.zero,
        // backgroundColor: Colors.red,
      ),
      child: Text(
        AppLocale.contact.translate(context),
        style: context.myTheme.textThemeT1.title
            .copyWith(color: AppColor.mainColor, fontSize: 16),
      ),
    );
  }

  Widget buildButtonLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: ElevatedButton(
              onPressed: () {
                controller.login(
                    username: controller.usernameController.text,
                    password: controller.passwordController.text,
                    context: context);
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
                AppLocale.login.translate(context),
                style: context.myTheme.textThemeT1.title
                    .copyWith(color: Colors.white),
              )),
        ),
        buildAction(context),
      ],
    );
  }

  Widget buildBiometricLoginButton(BuildContext context) {
    // Xác định icon dựa trên loại biometric
    IconData biometricIcon = Icons.fingerprint;
    if (_biometricTypeName.contains('Face ID') || _biometricTypeName.contains('Face')) {
      biometricIcon = Icons.face;
    } else if (_biometricTypeName.contains('Vân tay') || _biometricTypeName.contains('Fingerprint')) {
      biometricIcon = Icons.fingerprint;
    }

    return Center(
      child: InkWell(
        onTap: () {
          controller.loginWithBiometric(context);
        },
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: const Color.fromARGB(255, 229, 59, 59).withOpacity(0.5),
              width: 1.5,
            ),
            color: const Color.fromARGB(255, 229, 59, 59).withOpacity(0.05),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                biometricIcon,
                size: 20,
                color: const Color.fromARGB(255, 229, 59, 59),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocale.loginWithBiometric.translate(context),
                style: context.myTheme.textThemeT1.title.copyWith(
                  color: const Color.fromARGB(255, 229, 59, 59),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPassword(BuildContext context) {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: !_showPassword,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(),
        labelText: AppLocale.password.translate(context),
        floatingLabelStyle: context.myTheme.textThemeT1.title
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
            !_showPassword ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      style: context.myTheme.textThemeT1.body.copyWith(fontSize: 16),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) {
        controller.login(
            username: controller.usernameController.text,
            password: controller.passwordController.text,
            context: context);
      },
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
              errorText:
                  AppLocale.formRequiredPasswordError.translate(context)),
        ],
      ),
    );
  }

  TextFormField buildUserName(BuildContext context) {
    return TextFormField(
      controller: controller.usernameController,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(),
        labelText: AppLocale.username.translate(context),
        floatingLabelStyle: context.myTheme.textThemeT1.title
            .copyWith(fontWeight: FontWeight.normal),
        labelStyle: context.myTheme.textThemeT1.title.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
      style: context.myTheme.textThemeT1.body.copyWith(fontSize: 16),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
              errorText:
                  AppLocale.formRequiredUsernameError.translate(context)),
        ],
      ),
    );
  }

  Row buildIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/app_cr_icon.png",
          height: 120,
          fit: BoxFit.contain,
        ),
        // const SizedBox(
        //   width: 20,
        // ),
        // Image.asset(
        //   "assets/icons/app_icon_oval.png",
        //   height: 120,
        //   fit: BoxFit.contain,
        // ),
      ],
    );
  }
}

// class SocialAuthWidget extends StatelessWidget {
//   const SocialAuthWidget({super.key, required this.cubit});
//   final LoginCubit cubit;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             cubit.loginWithGoogle();
//           },
//           child: Container(
//             height: 50,
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: BoxDecoration(
//                 border: Border.all(width: 0.5, color: const Color(0xFF979696)),
//                 borderRadius: const BorderRadius.all(Radius.circular(100))),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                   AppImages.google,
//                   height: 30,
//                   width: 30,
//                 ),
//                 const HSpacing(),
//                 Text(
//                   'Đăng nhập với Google',
//                   style: context.myTheme.textThemeT1.body,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
