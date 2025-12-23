import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../controller/news_controller.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends BaseViewStateful<NewsPage, NewsController> {
  @override
  NewsController dependencyController() {
    // TODO: implement dependencyController
    return NewsController();
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
            AppLocale.news.translate(context),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    return Obx(
      () => controller.data.value == null
          ? buildEmptyLayout()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  controller.data.value?.thumbnailLink ?? "",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  controller.data.value?.tieuDe ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Html(
                  data: controller.data.value?.noiDung1,
                ),
                // const SizedBox(height: 16),
                // Text(
                //   'Người đăng: ${controller.data.value?.createdBy ?? ""}',
                //   style: const TextStyle(
                //     fontStyle: FontStyle.italic,
                //     color: Colors.grey,
                //   ),
                // ),
                const SizedBox(height: 8),
                Text(
                  'Ngày đăng: ${controller.data.value?.createdOn?.dateTimeHourString ?? ""}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: Get.mediaQuery.padding.bottom,
                )
              ],
            ),
    );
  }
}
