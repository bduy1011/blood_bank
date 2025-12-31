import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/components/blood_search_bar.dart';
import 'package:blood_donation/models/donation_blood_history_response.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/config/routes.dart';
import '../../home/models/home_category.dart';
import '../controller/blood_locations_history_controller.dart';

class BloodLocationsHistoryPage extends StatefulWidget {
  const BloodLocationsHistoryPage({super.key});

  @override
  State<BloodLocationsHistoryPage> createState() =>
      _BloodLocationsHistoryPageState();
}

class _BloodLocationsHistoryPageState extends BaseViewStateful<
    BloodLocationsHistoryPage, BloodLocationsHistoryController> {
  @override
  BloodLocationsHistoryController dependencyController() {
    // TODO: implement dependencyController
    return BloodLocationsHistoryController();
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
            tag: HomeCategory.bloodDonationHistory.name,
            child: Text(
              AppLocale.bloodDonationHistory.translate(context),
              maxLines: 2,
              textAlign: TextAlign.center,
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
          actions: const [
            // IconButton(
            //     onPressed: () async {
            //       controller.onFilter(context);
            //     },
            //     icon: SvgPicture.asset(
            //       "assets/icons/ic_location_filter.svg",
            //       width: 20,
            //       color: Colors.white,
            //     ))
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
              if (controller
                      .appCenter.authentication?.dmNguoiHienMau?.soLanHienMau !=
                  null) ...[
                const SizedBox(
                  height: 10,
                ),
                Text(
                    controller.appCenter.authentication?.dmNguoiHienMau
                                ?.soLanHienMau !=
                            null
                        ? "Số lần đã hiến máu: ${controller.appCenter.authentication?.dmNguoiHienMau?.soLanHienMau}"
                        : "",
                    style: context.myTheme.textThemeT1.title)
              ],
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
                          return buildItem(context, item,
                              controller.dataHistorySearch.length - index);
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
      BuildContext context, DonationBloodHistoryResponse item, int index) {
    return GestureDetector(
      onTap: () {
        controller.onClickItem(item);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                blurStyle: BlurStyle.outer)
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text("${AppLocale.time.translate(context)} $index",
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic)),
                const SizedBox(height: 5),
                Container(
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
                ),
              ],
            ),
            const HSpacing(
              spacing: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.tenSanPham ?? "",
                  style: context.myTheme.textThemeT1.title,
                ),
                // Row(
                //   children: [
                //     const Icon(Icons.bloodtype_outlined,
                //         size: 14, color: Colors.black54),
                //     const SizedBox(
                //       width: 3,
                //     ),
                //     Text(
                //       "${item.theTich ?? "0"} ml",
                //       style: context.myTheme.textThemeT1.body
                //           .copyWith(color: Colors.black87),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    const Icon(Icons.gas_meter_outlined,
                        size: 14, color: Colors.black54),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      item.maVachId ?? "",
                      style: context.myTheme.textThemeT1.body
                          .copyWith(color: Colors.black87),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined,
                        size: 14, color: Colors.black54),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      item.ngayThu != null
                          ? "Tiếp nhận lúc: ${DateFormat("dd/MM/yyyy HH:mm").format(item.ngayThu!)}"
                          : "",
                      style: context.myTheme.textThemeT1.body
                          .copyWith(color: Colors.black87),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.medical_information_outlined,
                        size: 14, color: Colors.black54),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Điều chế lúc:   ${DateFormat("dd/MM/yyyy HH:mm").format(item.ngaySanXuat ?? item.ngayThu!.add(const Duration(hours: 3, minutes: 27)))}",
                      style: context.myTheme.textThemeT1.body
                          .copyWith(color: Colors.black87),
                    ),
                  ],
                ),
                if (item.ghiChuTuiMau?.isNotEmpty == true)
                  Row(
                    children: [
                      const Icon(Icons.beenhere_outlined,
                          size: 14, color: Color.fromARGB(137, 0, 0, 0)),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        item.ghiChuTuiMau ?? "",
                        style: context.myTheme.textThemeT1.body
                            .copyWith(color: Colors.black87),
                      ),
                    ],
                  ),
                Text(
                  item.description ?? "",
                  style: context.myTheme.textThemeT1.body.copyWith(
                      color: item.isHyperlink == null
                          ? Colors.blue.shade900
                          : Colors.red.shade900),
                ),
                // RichText(
                //   text: TextSpan(
                //     text: "Kết quả xet nghiệm: ",
                //     style: context.myTheme.textThemeT1.body
                //         .copyWith(
                //             color: Colors.black87,
                //             fontWeight: FontWeight.w600),
                //     children: [
                //       TextSpan(
                //         text: item.description ?? "--",
                //         style: context.myTheme.textThemeT1.body
                //             .copyWith(color: Colors.black87),
                //       ),
                //     ],
                //   ),
                // ),
                // RichText(
                //   text: TextSpan(
                //     text: "Kết quả HbsAg: ",
                //     style: context.myTheme.textThemeT1.body
                //         .copyWith(
                //             color: Colors.black87,
                //             fontWeight: FontWeight.w600),
                //     children: [
                //       TextSpan(
                //         text: item.ketQuaHbsAgDescription ?? "",
                //         style: context.myTheme.textThemeT1.body
                //             .copyWith(
                //                 color: Colors.black87,
                //                 fontWeight: FontWeight.w600),
                //       ),
                //     ],
                //   ),
                // ),
                // if (item.ketQuaHIVDescription
                //         ?.toLowerCase()
                //         .contains("âm tính") ==
                //     true)
                //   RichText(
                //     text: TextSpan(
                //       text: "Kết quả xét nghiệm HIV: ",
                //       style: context.myTheme.textThemeT1.body
                //           .copyWith(
                //               color: Colors.black87,
                //               fontWeight: FontWeight.w600),
                //       children: [
                //         TextSpan(
                //           text: item.ketQuaHIVDescription ?? "",
                //           style: context.myTheme.textThemeT1.body
                //               .copyWith(
                //                   color: Colors.black87,
                //                   fontWeight: FontWeight.w600),
                //         ),
                //       ],
                //     ),
                //   ),
                // RichText(
                //   text: TextSpan(
                //     text: "Kết quả xét nghiệm giang mai: ",
                //     style: context.myTheme.textThemeT1.body
                //         .copyWith(
                //             color: Colors.black87,
                //             fontWeight: FontWeight.w600),
                //     children: [
                //       TextSpan(
                //         text:
                //             item.ketQuaGiangMaiDescription ?? "",
                //         style: context.myTheme.textThemeT1.body
                //             .copyWith(
                //                 color: Colors.black87,
                //                 fontWeight: FontWeight.w600),
                //       ),
                //     ],
                //   ),
                // ),
                // RichText(
                //   text: TextSpan(
                //     text: "Kết quả xét nghiệm sốt rét: ",
                //     style: context.myTheme.textThemeT1.body
                //         .copyWith(
                //             color: Colors.black87,
                //             fontWeight: FontWeight.w600),
                //     children: [
                //       TextSpan(
                //         text: item.ketQuaSotRetDescription ?? "",
                //         style: context.myTheme.textThemeT1.body
                //             .copyWith(
                //                 color: Colors.black87,
                //                 fontWeight: FontWeight.w600),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ))
          ],
        ),
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
              text: '${AppLocale.updateIdCard.translate(context)} ',
              style: context.myTheme.textThemeT1.body,
              children: [
                TextSpan(
                  text: AppLocale.here.translate(context),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      ///
                      await Get.toNamed(Routes.profile);
                      controller.loadData();
                    },
                  style: context.myTheme.textThemeT1.body.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.mainColor),
                ),
                TextSpan(
                  text: AppLocale.toViewDonationHistory.translate(context),
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
          '${AppLocale.noData.translate(context)}${controller.startDate?.ddmmyyyy != null ? " ${AppLocale.fromDate.translate(context)} ${controller.startDate!.ddmmyyyy}" : ""}${controller.endDate?.ddmmyyyy != null ? " ${AppLocale.toDay.translate(context)} ${controller.endDate!.ddmmyyyy}" : ""}',
          style: Get.context?.myTheme.textThemeT1.body,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
