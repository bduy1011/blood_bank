import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

import '../../components/blood_filter.dart';

class BloodUsersController extends BaseModelStateful {
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
    super.onInit();
  }

  Future<void> onFilter(BuildContext context) async {
    var rs = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(),
      backgroundColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
      builder: (context) {
        return const BloodFilter();
      },
    );
    if (rs == true) {
      // loadData();
    }
  }
}
