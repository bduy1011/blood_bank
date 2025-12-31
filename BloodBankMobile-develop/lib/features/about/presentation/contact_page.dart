import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/about_controller.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _AboutPageState();
}

class _AboutPageState extends BaseViewStateful<ContactPage, AboutController> {
  @override
  AboutController dependencyController() {
    // TODO: implement dependencyController
    return AboutController();
  }

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          title: Text(
            AppLocale.contact.translate(context),
            style:
                context.myTheme.textThemeT1.title.copyWith(color: Colors.white),
          ),
        ),
        body: Container(
          height: context.screenHeight,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildContent(),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Logo Image
                Center(
                  child: Image.asset(
                    "assets/icons/app_icon_oval.png",
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                // Title and Content
                RichText(
                  text: TextSpan(
                    text: "TRUNG TÂM TRUYỀN MÁU CHỢ RẪY",
                    style: context.myTheme.textThemeT1.title
                        .copyWith(height: 1.2, fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: "\n\nĐịa chỉ: ",
                        style: context.myTheme.textThemeT1.title.copyWith(
                          height: 1.2,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Bệnh viện Chợ Rẫy - 201B Nguyễn Chí Thanh, phường 12, Quận 5, TP.Hồ Chí Minh.",
                        style: context.myTheme.textThemeT1.body.copyWith(
                          height: 1.2,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "\n\nĐiện thoại: ",
                        style: context.myTheme.textThemeT1.title.copyWith(
                          height: 1.2,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                          text: "",
                          style: context.myTheme.textThemeT1.body.copyWith(
                            height: 1.2,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "028.38554137",
                              style: context.myTheme.textThemeT1.title.copyWith(
                                height: 1.2,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 103, 27, 27),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //callPhone("028.38554137");
                                  launchUrl(Uri.parse("tel:02838554137"),
                                      mode: LaunchMode.externalApplication);
                                },
                            ),
                            TextSpan(
                              text: " - số nội bộ 1162 hoặc ",
                              style: context.myTheme.textThemeT1.body.copyWith(
                                height: 1.2,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "028.39555885",
                              style: context.myTheme.textThemeT1.title.copyWith(
                                height: 1.2,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 103, 27, 27),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //callPhone("028.39555885");
                                  launchUrl(Uri.parse("tel:02839555885"),
                                      mode: LaunchMode.externalApplication);
                                },
                            ),
                            TextSpan(
                              text: " (liên hệ trong giờ hành chính).",
                              style: context.myTheme.textThemeT1.body.copyWith(
                                height: 1.2,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.white,
                        backgroundColor: AppColor.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20)),
                    onPressed: () {
                      //
                      launchUrl(
                          Uri.parse(
                              "https://www.facebook.com/profile.php?id=100092550263066"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/auth_options/facebook.png",
                          width: 35,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              AppLocale.contactViaFanpage.translate(context),
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
