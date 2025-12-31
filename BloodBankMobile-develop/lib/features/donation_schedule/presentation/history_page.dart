import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/models/blood_donation_event.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';
import '../../../utils/redirect_to_google_utils.dart';
import '../../components/blood_search_bar.dart';
import '../../home/models/home_category.dart';
import '../controller/donation_schedule_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState
    extends BaseViewStateful<HistoryPage, DonationScheduleController> {
  @override
  DonationScheduleController dependencyController() {
    // TODO: implement dependencyController
    return DonationScheduleController();
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
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Hero(
            tag: HomeCategory.bloodDonationSchedule.name,
            child: Text(
              AppLocale.bloodDonationSchedule.translate(context),
              style: context.myTheme.textThemeT1.title
                  .copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.transparent,
          surfaceTintColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
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
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              const SizedBox(height: 15),
              BloodSearchBar(
                hintText: "${AppLocale.search.translate(context)}...",
                onChange: (text) {
                  ///
                  controller.onSearch(text ?? "");
                },
              ),
              Expanded(
                  child: controller.bloodDonationEventsSearch.isEmpty
                      ? buildEmptyLayout()
                      : ListView.separated(
                          itemCount:
                              controller.bloodDonationEventsSearch.length,
                          padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16)
                              .copyWith(bottom: Get.mediaQuery.padding.bottom),
                          itemBuilder: (context, index) {
                            final item =
                                controller.bloodDonationEventsSearch[index];
                            return buildItemHistory(item, context);
                          },
                          separatorBuilder: (context, index) {
                            return const VSpacing(
                              spacing: 20,
                            );
                          },
                        ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemHistory(BloodDonationEvent item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.gotoDonationBlood(item);
      },
      child: Container(
        decoration: BoxDecoration(
            color: item.isDuocDangKy == true
                ? const Color.fromARGB(255, 248, 243, 243)
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(255, 90, 90, 90).withOpacity(0.6),
                  blurRadius: 3,
                  blurStyle: BlurStyle.outer)
            ]),
        child: buildItem(context, item),
      ),
    );
  }

  Widget buildItem(BuildContext context, BloodDonationEvent item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextContent(item, context),
        const VSpacing(
          spacing: 5,
        ),
        buildItemTime(item, context),
        const VSpacing(
          spacing: 10,
        ),
        buildItemLocation(item, context),
      ],
    );
  }

  Widget buildTextContent(BloodDonationEvent item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.ten ?? "",
            style: context.myTheme.textThemeT1.title.copyWith(
              color: item.isDuocDangKy == true
                  ? const Color(0xff5c0101)
                  : Colors.black38,
            ),
          ),
          Text(
            item.diaDiemToChuc ?? '',
            style: context.myTheme.textThemeT1.title.copyWith(
              color: item.isDuocDangKy == true
                  ? const Color(0xff5c0101)
                  : Colors.black38,
            ),
          ),
          const VSpacing(
            spacing: 5,
          ),
          Text(
            "Địa chỉ: ${(item.tenXa?.trim().isNotEmpty == true) ? "${item.tenXa}, " : ""}${item.tenHuyen}, ${item.tenTinh}",
            style: context.myTheme.textThemeT1.body.copyWith(
              color: item.isDuocDangKy == true ? Colors.black : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }

  Path customPath = Path()
    ..moveTo(Get.width / 2, 0)
    ..lineTo(Get.width / 2, 40)
    ..moveTo(0, 0)
    ..lineTo(Get.width - 30, 0);

  Widget buildItemLocation(BloodDonationEvent item, BuildContext context) {
    return DottedBorder(
      customPath: (size) => customPath,
      color: Colors.grey,
      child: Row(
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person,
                    color: Color(0xff0020aa),
                    size: 20,
                  ),
                  const HSpacing(
                    spacing: 4,
                  ),
                  Text(
                    "Đã đăng ký: ${item.soLuongDangKyHienMau ?? 0}/${item.soLuongDuKien}",
                    style: context.myTheme.textThemeT1.body.copyWith(
                      color: const Color(0xff0020aa),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (item.googleMapLink?.isNotEmpty == true) {
                  ProcessWebviewDialog.instance
                      .openGoogleMapRoadToUrlAddress(item.googleMapLink ?? "");
                } else {
                  AppUtils.instance.showToast(AppLocale.cannotFindRoute.translate(context));
                }
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xff0020aa),
                      size: 20,
                    ),
                    const HSpacing(
                      spacing: 4,
                    ),
                    Text(
                      AppLocale.road.translate(context),
                      style: context.myTheme.textThemeT1.body.copyWith(
                        color: const Color(0xff0020aa),
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget buildItemTime(BloodDonationEvent item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          .copyWith(top: 3),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 248, 209, 209),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time,
                color: Color(0xff5c0101),
                size: 20,
              ),
              const HSpacing(
                spacing: 4,
              ),
              Text(
                item.ngayGio?.timeHourString ?? "",
                style: context.myTheme.textThemeT1.body
                    .copyWith(color: Colors.black87),
              ),
              // const HSpacing(
              //   spacing: 10,
              // ),
              Text(
                " ・ ${item.ngayGio?.ddmmyyyy}",
                style: context.myTheme.textThemeT1.body
                    .copyWith(color: Colors.black87),
              ),
            ],
          ),
          // const HSpacing(
          //   spacing: 10,
          // ),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     const Icon(
          //       Icons.calendar_month_outlined,
          //       color: Color(0xffb22930),
          //       size: 20,
          //     ),
          //     const HSpacing(
          //       spacing: 4,
          //     ),
          //     Text(
          //       item.ngayGio?.ddmmyyyy ?? "",
          //       style: context.myTheme.textThemeT1.body
          //           .copyWith(color: Colors.black87),
          //     ),
          //   ],
          // ),
          // const HSpacing(
          //   spacing: 10,
          // ),
          Text(
            " ・ ${item.ngayGio?.dayInWeek}",
            style: context.myTheme.textThemeT1.body
                .copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildEmptyLayout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          '${AppLocale.noData.translate(context)}\r\n${AppLocale.fromToDate.translate(context).replaceAll('{fromDate}', controller.startDate?.ddmmyyyy ?? '').replaceAll('{toDate}', controller.endDate?.ddmmyyyy ?? '')}',
          style: Get.context?.myTheme.textThemeT1.body,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
