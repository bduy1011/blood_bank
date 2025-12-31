import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/about_controller.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends BaseViewStateful<AboutPage, AboutController> {
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
            AppLocale.appInformation.translate(context),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                RichText(
                  text: TextSpan(
                    text: "TRUNG TÂM TRUYỀN MÁU CHỢ RẪY",
                    style: context.myTheme.textThemeT1.title
                        .copyWith(height: 1.2, fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: "\n\n${AppLocale.address.translate(context)}",
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
                        text: "\n\n${AppLocale.phone.translate(context)}",
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
                              text: "${AppLocale.extension.translate(context)}1162${AppLocale.or.translate(context)}",
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
                              text: AppLocale.contactDuringBusinessHours.translate(context),
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
                const SizedBox(height: 40),

                // Version and Date
                Obx(
                  () => Text(
                    '${AppLocale.version.translate(context)}${controller.appVersion.value}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${AppLocale.updateDate.translate(context)}24/02/2025',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 50),
                // Thank You Note
                Text(
                  AppLocale.thankYouForUsingApp.translate(context),
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Add logic for reviewing the app here
                        controller.reviewAPP();
                      },
                      child: Text(
                        AppLocale.rateApp.translate(context),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // App Review Button
        // SizedBox(
        //   width: 200,
        //   height: 50,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.red,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //     ),
        //     onPressed: () {
        //       // Add logic for reviewing the app here
        //       controller.reviewAPP();
        //     },
        //     child: const Text(
        //       'ĐÁNH GIÁ APP',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: Get.mediaQuery.padding.top,
        // )
      ],
    );
  }
}
