import 'package:blood_donation/app/app_util/enum.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/components/blood_search_bar.dart';
import 'package:blood_donation/models/register_donation_blood_history_response.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/config/routes.dart';
import '../../../app/theme/colors.dart';
import '../../home/models/home_category.dart';
import '../controller/blood_locations_donate_controller.dart';

class BloodLocationsDonatePage extends StatefulWidget {
  const BloodLocationsDonatePage({super.key});

  @override
  State<BloodLocationsDonatePage> createState() =>
      _BloodLocationsDonatePageState();
}

class _BloodLocationsDonatePageState extends BaseViewStateful<
    BloodLocationsDonatePage, BloodLocationsController> {
  @override
  BloodLocationsController dependencyController() {
    // TODO: implement dependencyController
    return BloodLocationsController();
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
          title: Hero(
            tag: HomeCategory.bloodDonationRegister.name,
            child: Text(
              AppLocale.bloodDonationRegister.translate(context),
              style: context.myTheme.textThemeT1.title.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  controller.onFilter(context);
                },
                icon: SvgPicture.asset(
                  "assets/icons/ic_location_filter.svg",
                  width: 20,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              BloodSearchBar(
                hintText: "${AppLocale.search.translate(context)}...",
                onChange: (text) {
                  ///
                  controller.search(text);
                },
              ),
              Expanded(
                child: controller.dataHistorySearch.isEmpty
                    ? buildEmpty(context)
                    : ListView.separated(
                        itemCount: controller.dataHistorySearch.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 16),
                        itemBuilder: (context, index) {
                          var item = controller.dataHistorySearch[index];
                          return buildItem(item, context);
                        },
                        separatorBuilder: (context, index) => const VSpacing(
                          spacing: 20,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
      RegisterDonationBloodHistoryResponse item, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              blurStyle: BlurStyle.outer)
        ],
        color: const Color.fromARGB(255, 248, 243, 243),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildItemIcon(),
              const HSpacing(
                spacing: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.hoVaTen ?? "",
                      style: context.myTheme.textThemeT1.title,
                    ),
                    buildDate(item, context),
                    buildPhone(item, context),
                    buildStatus(item, context),
                    if (item.tinhTrang != TinhTrangDangKyHienMau.Huy.value &&
                        (DateUtils.dateOnly(item.ngay!).isAfter(
                                    DateUtils.dateOnly(DateTime.now())) ==
                                true ||
                            DateUtils.dateOnly(item.ngay!).isAtSameMomentAs(
                                DateUtils.dateOnly(DateTime.now()))))
                      buildActionCancel(item),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          buildAction(item, context)
        ],
      ),
    );
  }

  Path customPath = Path()
    ..moveTo((Get.width - 30) / 2, 0)
    ..lineTo((Get.width - 30) / 2, 40)
    ..moveTo(0, 0)
    ..lineTo(Get.width - 46, 0);

  Widget buildAction(
      RegisterDonationBloodHistoryResponse item, BuildContext context) {
    return DottedBorder(
      customPath: (size) => customPath,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                ///
                controller.exportQrCode(item);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.qr_code,
                      color: AppColor.mainColor,
                      size: 16,
                    ),
                    HSpacing(
                      spacing: 4,
                    ),
                    Text(
                      "Xuất mã QR",
                      style: TextStyle(color: AppColor.mainColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                ///
                controller.viewRoad(item);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xff0020aa),
                      size: 16,
                    ),
                    const HSpacing(
                      spacing: 3,
                    ),
                    Text(
                      AppLocale.road.translate(context),
                      style: const TextStyle(color: Color(0xff0020aa)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildActionCancel(RegisterDonationBloodHistoryResponse item) {
    return GestureDetector(
      onTap: () {
        ///
        controller.cancelRegisterDonate(item);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        color: Colors.transparent,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete,
              color: AppColor.mainColor,
              size: 16,
            ),
            HSpacing(
              spacing: 4,
            ),
            Text(
              "Hủy đăng ký",
              style: TextStyle(color: AppColor.mainColor),
            ),
          ],
        ),
      ),
    );
  }

  Row buildStatus(
      RegisterDonationBloodHistoryResponse item, BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.watch_later_rounded, size: 14, color: Colors.black54),
        const SizedBox(
          width: 3,
        ),
        Text(
          "Tình trạng: ${item.tinhTrangDescription}",
          style:
              context.myTheme.textThemeT1.body.copyWith(color: Colors.black87),
        ),
      ],
    );
  }

  Row buildPhone(
      RegisterDonationBloodHistoryResponse item, BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.phone, size: 14, color: Colors.black54),
        const SizedBox(
          width: 3,
        ),
        Text(
          item.soDT ?? "",
          style:
              context.myTheme.textThemeT1.body.copyWith(color: Colors.black87),
        ),
      ],
    );
  }

  Row buildDate(
      RegisterDonationBloodHistoryResponse item, BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_month_outlined,
            size: 14, color: Colors.black54),
        const SizedBox(
          width: 3,
        ),
        Text(
          item.ngay != null
              ? DateFormat("dd/MM/yyyy HH:mm").format(item.ngay!)
              : "",
          style:
              context.myTheme.textThemeT1.body.copyWith(color: Colors.black87),
        ),
      ],
    );
  }

  Container buildItemIcon() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                blurStyle: BlurStyle.outer)
          ],
          color: Colors.red.withOpacity(0.2)),
      child: Image.asset(
        "assets/icons/app_icon_circle.png",
        width: 50,
        //height: 30,
        //fit: BoxFit.scaleDown,
        // colorFilter: ColorFilter.mode(
        //     context.myTheme.colorScheme.primary, BlendMode.srcIn),
      ),
    );
  }

  Widget buildEmpty(BuildContext context) {
    if (controller.appCenter.authentication?.cmnd?.isNotEmpty != true) {
      //
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Cập nhật CCCD/Căn cước',
              style: context.myTheme.textThemeT1.body,
              children: [
                TextSpan(
                  text: 'Tại đây',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      ///
                      await Get.toNamed(Routes.profile);
                      controller.loadData();
                    },
                  style: context.myTheme.textThemeT1.body.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.mainColor),
                ),
                const TextSpan(
                  text: ' để xem lịch sử đăng ký hiến máu của bạn.',
                )
              ],
            ),
          ),
        ),
      );
    }
    return buildEmptyLayout();
  }

  @override
  Widget buildEmptyLayout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'Không có dữ liệu từ ngày ${controller.startDate?.ddmmyyyy} đến ngày  ${controller.endDate?.ddmmyyyy}',
          style: Get.context?.myTheme.textThemeT1.body,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
