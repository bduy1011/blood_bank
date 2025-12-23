import 'package:blood_donation/base/base_view/base_view.dart';

import '../models/personality_group.dart';

class QuestionAnswerController extends BaseModelStateful {
  List<bool> isExpandedList =
      List.generate(PersonalityGroup.values.length, (index) => false);
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
}
