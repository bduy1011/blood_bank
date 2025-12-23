import 'package:blood_donation/utils/extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_model_stateless.dart';
import 'mixin/base_view_mixin.dart';

abstract class BaseViewStateless<T extends BaseModelStateless>
    extends StatelessWidget with BaseViewMixin {
  const BaseViewStateless({super.key});

  ///
  /// example \
  /// dependencyController() { \
  ///   return Get.put(T(), tag: tag);\
  /// }\
  T dependencyController();
  final String? tag = null;

  ///if don't using at client => don't new object (dependencyController fun don't call)
  ///controller is singleton in follow tag
  @override
  T get controller => Get.findOrNull<T>(tag: tag) ?? dependencyController();

  ///
  ///
}
