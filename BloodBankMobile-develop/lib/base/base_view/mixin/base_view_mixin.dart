import 'package:blood_donation/app/app_util/app_center.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../app/app_util/app_state.dart';
import '../../../core/backend/backend_provider.dart';
import '../../../core/storage/local_storage.dart';

mixin BaseModel {
  // Local Storage
  LocalStorage get localStorage => LocalStorage();
  BackendProvider get backendProvider => BackendProvider();
  AppCenter get appCenter => GetIt.instance<AppCenter>();
  final status = PageStatus.loading;
  void onBack() {}

  void onTapRightMenu() {}

  void showLoading() {
    AppUtils.instance.showLoading();
  }

  void hideLoading() {
    AppUtils.instance.hideLoading();
  }
}

mixin BaseViewMixin<T extends BaseModel> {
  String? get title => null;

  String? get rightAsset => null;
  String? get backAsset => null;

  T get controller;

  Widget buildEmptyLayout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'Không có dữ liệu',
          style: Get.context?.myTheme.textThemeT1.body,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildLoadingLayout() {
    return Container();
  }

  Widget buildDisconnectLayout() {
    return Container();
  }

  Widget buildHeader() {
    return const SizedBox();
  }
}
