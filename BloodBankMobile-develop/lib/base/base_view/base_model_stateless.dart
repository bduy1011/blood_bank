import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_view.dart';

abstract class BaseModelStateless extends DisposableInterface with BaseModel {
  ///

  /// Method to be overridden by subclasses for additional initialization.
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
  }

  /// Method to show a loading indicator.
  void onLoading() {
    // Implement your loading indicator logic here
  }

  /// Method to hide the empty data indicator.
  void onEmpty() {
    // Implement your hide empty indicator logic here
  }

  /// Method to hide the ready indicator.
  @mustCallSuper
  @override
  void onReady() {
    // Implement your hide ready indicator logic here
    super.onReady();
  }

  /// Method to hide the error indicator.
  void onError() {
    // Implement your hide error indicator logic here
  }

  /// Method to hide the dispose indicator.
  @mustCallSuper
  @override
  void onClose() {
    // Implement your hide dispose indicator logic here
    super.onClose();
  }
}
