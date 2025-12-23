import 'package:blood_donation/utils/extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'base_model_stateful.dart';
import 'mixin/base_view_mixin.dart';

abstract class BaseViewStateful<T extends StatefulWidget,
    M extends BaseModelStateful> extends State<T> with BaseViewMixin<M> {
  BaseViewStateful({this.isReusable = false});
  final bool isReusable;

  ///dử dụng cho trường hợp controller local
  M? _controller;

  M _dependencyController() {
    if (isReusable) {
      return Get.put(dependencyController(), tag: tag);
    } else {
      _controller ??= dependencyController();
      return _controller!;
    }
  }

  ///
  /// example \
  /// isReusable = false\
  /// dependencyController() { \
  ///   return M();\
  /// }\
  M dependencyController();
  final String? tag = null;

  ///if don't using at client => don't new object (dependencyController fun don't call)
  ///controller is singleton in follow tag
  @override
  M get controller => Get.findOrNull<M>(tag: tag) ?? _dependencyController();

  @override
  void initState() {
    controller.setState = (fn) {
      if (mounted) {
        setState(fn);
      } else {
        fn.call();
      }
    };
    controller.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.onReady();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    controller.onDidUpdateWidget();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.onClose();
    if (isReusable) {
      Get.delete<M>(tag: tag);
    }
    super.dispose();
  }

  ///view
}
