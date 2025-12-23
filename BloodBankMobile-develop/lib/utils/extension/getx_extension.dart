import 'package:get/get.dart';

extension GetxExtension on GetInterface {
  S? findOrNull<S>({String? tag}) {
    if (Get.isRegistered<S>(tag: tag)) {
      return Get.find<S>(tag: tag);
    }

    return null;
  }
}
