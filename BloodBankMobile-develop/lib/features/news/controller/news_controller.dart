import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:get/get.dart';

import '../../../models/news_response.dart';

class NewsController extends BaseModelStateful {
  Rx<NewsResponse?> data = (null as NewsResponse?).obs;
  @override
  void onBack() {
    // TODO: implement onBack
  }

  @override
  void onTapRightMenu() {
    // TODO: implement onTapRightMenu
  }

  @override
  Future<void> onInit() async {
    ///
    getArgument();
    super.onInit();
  }

  void getArgument() {
    try {
      if (Get.arguments["news"] != null) {
        data.value = Get.arguments["news"] as NewsResponse;
      }
    } catch (e) {
      // TODO
    }
  }
}
