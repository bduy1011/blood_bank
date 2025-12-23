import 'package:blood_donation/base/base_view/base_model_stateful.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';

class AboutController extends BaseModelStateful {
  @override
  Future<void> onInit() async {
    super.onInit();
    getReleaseVersion();
  }

  Future<void> reviewAPP() async {
    try {
      final InAppReview inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      }
    } catch (e) {
      // TODO
      print(e);
    }
  }

  RxString appVersion = "".obs;
  Future<void> getReleaseVersion() async {
    final contents = await rootBundle.loadString("pubspec.yaml");
    final lines = contents.split('\n');

    for (var line in lines) {
      if (line.startsWith('version:')) {
        appVersion.value = line.split(':')[1].trim().split('+')[0].trim();
      }
    }
    return;
  }
}
