import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/question_answer/models/personality_group.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/icons.dart';
import '../../home/models/home_category.dart';
import '../controller/question_answer_controller.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({super.key});

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState
    extends BaseViewStateful<QuestionAnswerPage, QuestionAnswerController> {
  @override
  QuestionAnswerController dependencyController() {
    // TODO: implement dependencyController
    return QuestionAnswerController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFB22C2D),
            Color.fromARGB(255, 240, 88, 88),
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          title: Hero(
            tag: HomeCategory.questionAndAnswer.name,
            child: Text(
              AppLocale.questionAndAnswer.translate(context),
              style: context.myTheme.textThemeT1.title
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          height: context.screenHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  AppImages.imageQA,
                  height: 120,
                  width: Get.width,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              const VSpacing(
                spacing: 10,
              ),
              Expanded(
                child: ListView.separated(
                    itemCount: PersonalityGroup.values.length,
                    itemBuilder: (context, index) {
                      return buildItem(index, context);
                    },
                    separatorBuilder: (context, index) {
                      return const VSpacing(
                        spacing: 10,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(int index, BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        controller.isExpandedList[index] = !controller.isExpandedList[index];
      }),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 194, 194, 194)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  PersonalityGroup.values[index].icon,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    PersonalityGroup.values[index].title.toUpperCase(),
                    style: context.myTheme.textThemeT1.title.copyWith(
                        color: controller.isExpandedList[index]
                            ? const Color.fromARGB(255, 117, 13, 13)
                            : const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                Icon(
                  controller.isExpandedList[index]
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: Colors.black,
                )
              ],
            ),
            controller.isExpandedList[index]
                ? buildContentItem(context, PersonalityGroup.values[index])
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget buildContentItem(BuildContext context, PersonalityGroup value) {
    switch (value) {
      case PersonalityGroup.location:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text: "TRUNG TÂM TRUYỀN MÁU CHỢ RẪY",
              style: context.myTheme.textThemeT1.title
                  .copyWith(height: 1.2, fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: "\n\nĐịa chỉ: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text:
                      "Bệnh viện Chợ Rẫy - 201B Nguyễn Chí Thanh, phường 12, Quận 5, TP.Hồ Chí Minh.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n\nĐiện thoại: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                    text: "",
                    style: context.myTheme.textThemeT1.body.copyWith(
                      height: 1.2,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "028.38554137",
                        style: context.myTheme.textThemeT1.title.copyWith(
                          height: 1.2,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 103, 27, 27),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //callPhone("028.38554137");
                            launchUrl(Uri.parse("tel:02838554137"),
                                mode: LaunchMode.externalApplication);
                          },
                      ),
                      TextSpan(
                        text: " - số nội bộ 1162 hoặc ",
                        style: context.myTheme.textThemeT1.body.copyWith(
                          height: 1.2,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "028.39555885",
                        style: context.myTheme.textThemeT1.title.copyWith(
                          height: 1.2,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 103, 27, 27),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //callPhone("028.39555885");
                            launchUrl(Uri.parse("tel:02839555885"),
                                mode: LaunchMode.externalApplication);
                          },
                      ),
                      TextSpan(
                        text: " (liên hệ trong giờ hành chính).",
                        style: context.myTheme.textThemeT1.body.copyWith(
                          height: 1.2,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ])
              ],
            ),
          ),
        );
      case PersonalityGroup.time:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text: "Hiến máu: ",
              style: context.myTheme.textThemeT1.title.copyWith(
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 0, 38, 255),
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: "từ thứ 2 đến thứ 6 hàng tuần.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n •  Buổi sáng: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "   7:00 - 10:30",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n •  Buổi chiều: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "13:00 - 15:30",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n\nHiến tiểu cầu: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 0, 38, 255),
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: "từ thứ 2 đến thứ 6 hàng tuần.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n •  Buổi sáng: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text:
                      "7:00 - 9:00 (Có thể ngừng nhận đăng ký sớm hơn khi nhận nhu cầu).",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n\nHiến máu cuối tuần: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 0, 38, 255),
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: "Chủ nhật tuần thứ 2 hàng tháng.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n •  Buổi sáng: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "   7:00 - 10:30",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n •  Buổi chiều: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "13:00 - 15:30",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      case PersonalityGroup.condition:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text: "• Tuổi: ",
              style: context.myTheme.textThemeT1.title.copyWith(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: "18-60",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "\n•  Cân nặng: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "trên 45kg",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "\n•  Khoảng cách giữa 2 lần hiến máu: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "12 tuần",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "\n•  Khoảng cách giữa 2 lần hiến tiểu cầu: ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "14 ngày",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text:
                      "\n•  Bệnh lý: Không mắc các bệnh lây nhiễm qua đường truyền máu như ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "HIV/AIDS, viêm gan siêu vi B, C, Sốt rét, Giang mai. ",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text:
                      "Không mắc các bệnh tim, gan, thận, phổi, ung thư, tiểu đường, cao huyết áp, các bệnh về máu, v.v",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n•  Kết thúc chu kỳ kinh nguyệt ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "7 ngày ",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "(đối với nữ).",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "\n•  Ăn uống bình thường và ",
                  style: context.myTheme.textThemeT1.title.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "không thức khuya đêm trước hiến máu.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      case PersonalityGroup.note:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text:
                  "•  Khi đến hiến máu, quý vị vui lòng mang theo CCCD/Căn cước.",
              style: context.myTheme.textThemeT1.body.copyWith(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text:
                      "\n•  Người hiến máu gửi xe tại cổng 3 – Bệnh viện Chợ Rẫy, đường Thuận Kiều.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        );
      case PersonalityGroup.image:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ///
                  Get.to(
                    () => Stack(
                      children: [
                        PhotoView(
                          imageProvider: const AssetImage(AppImages.toRoi1),
                          errorBuilder: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Positioned(
                          top: Get.mediaQuery.padding.top + 5,
                          left: 5,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Image.asset(
                  AppImages.toRoi1,
                  width: Get.width,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ///
                  Get.to(() => Stack(
                        children: [
                          PhotoView(
                            imageProvider: const AssetImage(AppImages.toRoi2),
                            errorBuilder: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Positioned(
                            top: Get.mediaQuery.padding.top + 5,
                            left: 5,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ));
                },
                child: Image.asset(
                  AppImages.toRoi2,
                  width: Get.width,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      case PersonalityGroup.benefit:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text:
                  "Quyền lợi và chế độ đối với người hiến máu tình nguyện theo Thông tư số 05/2017/TT-BYT Quy định giá tối đa và chi phí phục vụ cho việc xác định giá một đơn vị máu toàn phần, chế phẩm máu đạt tiêu chuẩn:",
              style: context.myTheme.textThemeT1.body.copyWith(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: "\n•  Được khám và tư vấn sức khỏe miễn phí."
                      "\n•  Được kiểm tra và thông báo kết quả các xét nghiệm máu (hoàn toàn bí mật): nhóm máu, HIV, virut viêm gan B, virut viêm gan C, giang mai, sốt rét. Trong trường hợp người hiến máu có nhiễm hoặc nghi ngờ các mầm bệnh này thì sẽ được Bác sỹ mời đến để tư vấn sức khỏe."
                      "\n•  Được bồi dưỡng và chăm sóc theo các quy định hiện hành:"
                      "\n   + Phục vụ ăn nhẹ tại chỗ: tương đương 30.000 đồng."
                      "\n   + Hỗ trợ chi phí đi lại (bằng tiền mặt): 50.000 đồng."
                      "\n   + Lựa chọn nhận quà tặng bằng hiện vật có giá trị như sau: Một đơn vị máu thể tích 250 ml: 100.000 đồng. Một đơn vị máu thể tích 350 ml: 150.000 đồng. Một đơn vị máu thể tích 450 ml: 180.000 đồng."
                      "\n   + Được cấp giấy chứng nhận hiến máu tình nguyện của Ban chỉ đạo hiến máu nhân đạo Tỉnh, Thành phố. Ngoài giá trị về mặt tôn vinh, giấy chứng nhận hiến máu có giá trị bồi hoàn máu, số lượng máu được bồi hoàn lại tối đa bằng lượng máu người hiến máu đã hiến. Giấy Chứng nhận này có giá trị tại các bệnh viện, các cơ sở y tế công lập trên toàn quốc.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        );
      case PersonalityGroup.testing:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text:
                  "•  Tất cả những đơn vị máu thu được sẽ được kiểm tra nhóm máu (hệ ABO, hệ Rh), HIV, virus viêm gan B, virus viêm gan C, giang mai, sốt rét.",
              style: context.myTheme.textThemeT1.body.copyWith(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text:
                      "\n•  Bạn sẽ được thông báo kết quả, được giữ kín và được tư vấn (miễn phí) khi phát hiện ra các bệnh nhiễm trùng nói trên.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        );
      case PersonalityGroup.cmnd:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
                text:
                    "Mỗi đơn vị máu đều phải có hồ sơ, trong đó có các thông tin về người hiến máu.\nTheo quy định, đây là một thủ tục cần thiết trong quy trình hiến máu để đảm bảo tính xác thực thông tin về người hiến máu.",
                style: context.myTheme.textThemeT1.body.copyWith(
                  height: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      case PersonalityGroup.contagious:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
                text:
                    "Kim dây lấy máu vô trùng, chỉ sử dụng một lần cho một người, vì vậy không thể lây bệnh cho người hiến máu.",
                style: context.myTheme.textThemeT1.body.copyWith(
                  height: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      case PersonalityGroup.unwell:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
                text:
                    "Sau khi hiến máu, nếu có các triệu chứng chóng mặt, mệt mỏi, buồn nôn,... hãy liên hệ ngay cho đơn vị tiếp nhận máu để được hỗ trợ về mặt y khoa.",
                style: context.myTheme.textThemeT1.body.copyWith(
                  height: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      case PersonalityGroup.signs:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
                text:
                    "Sau khi hiến máu, nếu bạn có các dấu hiệu sưng, phù nơi vết chích. Xin đừng quá lo lắng, hãy chườm lạnh ngay vị trí sưng đó và theo dõi các dấu hiệu trên, nếu không giảm sau 24 giờ hãy liên hệ lại cho đơn vị tiếp nhận máu để được hỗ trợ.",
                style: context.myTheme.textThemeT1.body.copyWith(
                  height: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      case PersonalityGroup.preparedonate:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
                text:
                    "•  Tối nay bạn không nên thức quá khuya (ngủ trước 23:00)."
                    "\n•  Nên ăn và không uống rượu, bia trước khi hiến máu."
                    "\n•  Mang giấy CCCD/Căn cước, đủ giấy tờ tùy thân và thẻ hiến máu (nếu có) khi đi hiến máu.",
                style: context.myTheme.textThemeT1.body.copyWith(
                  height: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      case PersonalityGroup.abnormal:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
                text:
                    "Sau khi tham gia hiến máu, nếu phát hiện có bất cứ điều gì khiến bạn cảm thấy không an toàn với túi máu vừa hiến (chợt nhớ ra 1 hành vi nguy cơ, có sử dụng loại thuốc nào đó mà bạn quên báo bác sĩ khi thăm khám, có xét nghiệm 'DƯƠNG TÍNH' với SarS-CoV-2 bằng kỹ thuật test nhanh hoặc Real time RT-PCR,...) vui lòng báo lại cho đơn vị tiếp nhận túi máu nơi mà bạn đã tham gia hiến.",
                style: context.myTheme.textThemeT1.body.copyWith(
                  height: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      case PersonalityGroup.needblood:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text:
                  "Mỗi giờ có hàng trăm người bệnh cần phải được truyền máu vì:",
              style: context.myTheme.textThemeT1.body.copyWith(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text:
                      "\n•  Bị mất máu do chấn thương, tai nạn, thảm hoạ, xuất huyết tiêu hoá..."
                      "\n•  Do bị các bệnh gây thiếu máu, chảy máu: ung thư máu, suy tuỷ xương, máu khó đông..."
                      "\n•  Các phương pháp điều trị hiện đại cần truyền nhiều máu: phẫu thuật tim mạch, ghép tạng...",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        );
      case PersonalityGroup.health:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
              text:
                  "Hiến máu theo hướng dẫn của thầy thuốc không có hại cho sức khỏe. Điều đó đã được chứng minh bằng các cơ sở khoa học và cơ sở thực tế:",
              style: context.myTheme.textThemeT1.body.copyWith(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text:
                      "\n•  Máu có nhiều thành phần, mỗi thành phần chỉ có đời sống nhất định và luôn luôn được đổi mới hằng ngày. Ví dụ: Hồng cầu sống được 120 ngày, huyết tương thường xuyên được thay thế và đổi mới. Cơ sở khoa học cho thấy, nếu mỗi lần hiến dưới 1/10 lượng máu trong cơ thể thì không có hại đến sức khỏe."
                      "\n•  Nhiều công trình nghiên cứu đã chứng minh rằng, sau khi hiến máu, các chỉ số máu có thay đổi chút ít nhưng vẫn nằm trong giới hạn sinh lý bình thường không hề gây ảnh hưởng đến các hoạt động thường ngày của cơ thể."
                      "\n•  Thực tế đã có hàng triệu người hiến máu nhiều lần mà sức khỏe vẫn hoàn toàn tốt. Trên thế giới có người hiến máu trên 400 lần. Ở Việt Nam, người hiến máu nhiều lần nhất đã hiến gần 100 lần, sức khỏe hoàn toàn tốt."
                      "\n•  Như vậy, mỗi người nếu thấy sức khoẻ tốt, không có các bệnh lây nhiễm qua đường truyền máu, đạt tiêu chuẩn hiến máu thì có thể hiến máu từ 3-4 lần trong một năm, vừa không ảnh hưởng xấu đến sức khoẻ của bản thân, vừa đảm bảo máu có chất lượng tốt, an toàn cho người bệnh.",
                  style: context.myTheme.textThemeT1.body.copyWith(
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        );
      case PersonalityGroup.delay:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RichText(
            text: TextSpan(
                text:
                    "•  Những người phải trì hoãn hiến máu trong 12 tháng kể từ thời điểm:"
                    "\n   + Phục hồi hoàn toàn sau các can thiệp ngoại khoa."
                    "\n   + Khỏi bệnh sau khi mắc một trong các bệnh sốt rét, giang mai, lao, uốn ván, viêm não, viêm màng não."
                    "\n   + Kết thúc đợt tiêm vắc xin phòng bệnh dại sau khi bị động vật cắn hoặc tiêm, truyền máu, chế phẩm máu và các chế phẩm sinh học nguồn gốc từ máu."
                    "\n   + Sinh con hoặc chấm dứt thai nghén."
                    "\n\n•  Những người phải trì hoãn hiến máu trong 06 tháng kể từ thời điểm:"
                    "\n   + Xăm trổ trên da."
                    "\n   + Bấm dái tai, bấm mũi, bấm rốn hoặc các vị trí khác của cơ thể."
                    "\n   + Phơi nhiễm với máu và dịch cơ thể từ người có nguy cơ hoặc đã nhiễm các bệnh lây truyền qua đường máu."
                    "\n   + Khỏi bệnh sau khi mắc một trong các bệnh thương hàn, nhiễm trùng huyết, bị rắn cắn, viêm tắc động mạch, viêm tắc tĩnh mạch, viêm tuỷ xương, viêm tụy."
                    "\n\n•  Những người phải trì hoãn hiến máu trong 04 tuần kể từ thời điểm:"
                    "\n   + Khỏi bệnh sau khi mắc một trong các bệnh viêm dạ dày ruột, viêm đường tiết niệu, viêm da nhiễm trùng, viêm phế quản, viêm phổi, sởi, ho gà, quai bị, sốt xuất huyết, kiết lỵ, rubella, tả, quai bị."
                    "\n   + Kết thúc đợt tiêm vắc xin phòng rubella, sởi, thương hàn, tả, quai bị, thủy đậu, BCG."
                    "\n\n•  Những người phải trì hoãn hiến máu trong 07 ngày kể từ thời điểm:"
                    "\n   + Khỏi bệnh sau khi mắc một trong các bệnh cúm, cảm lạnh, dị ứng mũi họng, viêm họng, đau nửa đầu Migraine."
                    "\n   + Tiêm các loại vắc xin, trừ các loại đã được quy định tại Điểm c Khoản 1 và Điểm b Khoản 3 Điều này."
                    "\n\n•  Một số quy định liên quan đến nghề nghiệp và hoạt động đặc thù của người hiến máu: những người làm một số công việc và thực hiện các hoạt động đặc thù sau đây chỉ hiến máu trong ngày nghỉ hoặc chỉ được thực hiện các công việc, hoạt động này sau khi hiến máu tối thiểu 12 giờ:"
                    "\n   + Người làm việc trên cao hoặc dưới độ sâu: phi công, lái cần cẩu, công nhân làm việc trên cao, người leo núi, thợ mỏ, thủy thủ, thợ lặn."
                    "\n   + Người vận hành các phương tiện giao thông công cộng: lái xe buýt, lái tàu hoả, lái tàu thuỷ."
                    "\n   + Các trường hợp khác: vận động viên chuyên nghiệp, người vận động nặng, tập luyện nặng.",
                style: context.myTheme.textThemeT1.body.copyWith(
                  height: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      default:
    }
    return const SizedBox();
  }
}
