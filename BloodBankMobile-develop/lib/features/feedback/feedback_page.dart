import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/features/about/presentation/contact_page.dart';
import 'package:blood_donation/features/feedback/controller/feedback_controller.dart';
import 'package:blood_donation/models/feedback_respose.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme/icons.dart';
import '../../core/localization/app_locale.dart';
import '../home/models/home_category.dart';

class FeedbackSupportPage extends StatefulWidget {
  const FeedbackSupportPage({super.key});

  @override
  _FeedbackSupportPageState createState() => _FeedbackSupportPageState();
}

class _FeedbackSupportPageState
    extends BaseViewStateful<FeedbackSupportPage, FeedbackController> {
  @override
  FeedbackController dependencyController() {
    // TODO: implement dependencyController
    return FeedbackController();
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
          title: Hero(
            tag: HomeCategory.feedbackSupport.name,
            child: Text(
              AppLocale.feedbackSupport.translate(context),
              style: context.myTheme.textThemeT1.title
                  .copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.transparent,
          surfaceTintColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Image.asset(
                  AppImages.imageContact,
                  height: 120,
                  width: Get.width,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.zero, // Set this
                          padding: EdgeInsets.zero, // and this
                        ),
                        onPressed: () => controller.selectDateRange(context),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.fromDate == null &&
                                        controller.toDate == null
                                    ? AppLocale.selectTimeRange.translate(context)
                                    : '${AppLocale.fromToDate.translate(context).replaceAll('{fromDate}', controller.fromDate!.dateTimeString).replaceAll('{toDate}', controller.toDate!.dateTimeString)}',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(height: 50),
                            // IconButton(
                            //   padding: EdgeInsets.zero,
                            //   onPressed: () {
                            //     setState(() {
                            //       controller.fromDate = null;
                            //       controller.toDate = null;
                            //     });
                            //   },
                            //   icon: const Icon(Icons.clear),
                            //   tooltip: 'Xóa',
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: controller.feedbacks.isEmpty
                    ? buildEmptyLayout()
                    : ListView.builder(
                        itemCount: controller.feedbacks.length,
                        itemBuilder: (context, index) {
                          final feedback = controller.feedbacks[index];
                          return buildItem(feedback);
                        },
                      ),
              ),
              buildButtons(),
              SizedBox(
                height: Get.mediaQuery.padding.bottom + 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  //  await Get.toNamed(Routes.addFeedback);
  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
              onPressed: () {
                Get.to(() => const ContactPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/app_icon_circle.png",
                    width: 30,
                    //color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        AppLocale.contactInformation.translate(context),
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
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
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
              onPressed: () {
                //
                controller.sendFeedback();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_paper-plane.svg",
                    width: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        AppLocale.sendRequestDirectly.translate(context),
                        style: const TextStyle(color: Colors.white, fontSize: 16),
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
    );
  }

  Widget buildItem(FeedbackResponse feedback) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
          .copyWith(bottom: Get.mediaQuery.padding.bottom + 8),
      child: ListTile(
        title: Text(feedback.hoVaTen ?? ""),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(feedback.noiDung ?? ""),
            const SizedBox(height: 8),
            Text(
              feedback.ngay!.dateTimeHourString,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
