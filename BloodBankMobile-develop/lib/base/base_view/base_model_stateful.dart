import 'package:flutter/material.dart';

import 'base_view.dart';

abstract class BaseModelStateful with BaseModel {
  late void Function(VoidCallback fn) _setState;

  set setState(void Function(VoidCallback fn) v) {
    _setState = v;
  }

  void refresh({VoidCallback? fn}) {
    _setState.call(fn ?? () {});
  }

  /// Method to be overridden by subclasses for additional initialization.
  void onDidUpdateWidget() {}

  /// Method to be overridden by subclasses for additional initialization.
  @mustCallSuper
  Future<void> onInit() async {}

  /// Method to show a loading indicator.
  Future<void> onLoading() async {
    // Implement your loading indicator logic here
  }

  /// Method to hide the empty data indicator.
  Future<void> onEmpty() async {
    // Implement your hide empty indicator logic here
  }

  /// Method to hide the ready indicator.
  @mustCallSuper
  Future<void> onReady() async {
    // Implement your hide ready indicator logic here
  }

  /// Method to hide the error indicator.

  void onError() {
    // Implement your hide error indicator logic here
  }

  /// Method to hide the dispose indicator.
  @mustCallSuper
  Future<void> onClose() async {
    // Implement your hide dispose indicator logic here
  }
}
