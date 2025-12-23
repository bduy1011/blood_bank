import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/double_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/app_util/enum.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../controller/history_register_buy_blood_controller.dart';

class HistoryRegisterBuyBloodPage extends StatefulWidget {
  const HistoryRegisterBuyBloodPage({super.key, this.isNavigation = false});
  final bool isNavigation;

  @override
  State<HistoryRegisterBuyBloodPage> createState() =>
      _HistoryRegisterBuyBloodPageState();
}

class _HistoryRegisterBuyBloodPageState extends BaseViewStateful<
    HistoryRegisterBuyBloodPage, HistoryRegisterBuyBloodController> {
  @override
  HistoryRegisterBuyBloodController dependencyController() {
    // TODO: implement dependencyController
    return HistoryRegisterBuyBloodController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.mainColor,
            Color.fromARGB(255, 246, 103, 93),
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Danh sách đăng ký",
            style:
                context.myTheme.textThemeT1.title.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
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
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              buildTabbar(context),
              const VSpacing(),
              buildContent(),
              VSpacing(
                spacing: Get.mediaQuery.padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    if (controller.historys.isEmpty) {
      return Expanded(child: buildEmptyLayout());
    }
    return Expanded(
        child: ListView.separated(
      itemCount: controller.historys.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var history = controller.historys[index];
        return Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        blurStyle: BlurStyle.outer)
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(
                      //         color: context.myTheme.colorScheme.primary),
                      //     borderRadius: BorderRadius.circular(100)),
                      // width: 30,
                      // height: 30,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.numbers,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            history.giaoDichId.toString(),
                            style: context.myTheme.textThemeT1.title.copyWith(
                                color: context.myTheme.colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    const VSpacing(),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_box,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: (history.creatorName ?? "")
                                        .toUpperCase(),
                                    style: context.myTheme.textThemeT1.title),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_hospital,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Nơi nhượng máu: ",
                                    style: context.myTheme.textThemeT1.body),
                                TextSpan(
                                  text: history.donViCapMauName,
                                  style: context.myTheme.textThemeT1.body
                                      .copyWith(
                                          color: context
                                              .myTheme.colorScheme.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Thời gian: ",
                                    style: context.myTheme.textThemeT1.body),
                                TextSpan(
                                  text: history.ngay!.dateTimeHourString,
                                  style: context.myTheme.textThemeT1.body
                                      .copyWith(
                                          color: context
                                              .myTheme.colorScheme.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.assignment,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Loại phiếu: ",
                                    style: context.myTheme.textThemeT1.body),
                                TextSpan(
                                  text: history.loaiPhieuDescription,
                                  style: context.myTheme.textThemeT1.body
                                      .copyWith(
                                          color: context
                                              .myTheme.colorScheme.primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.info,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Tình trạng: ",
                                    style: context.myTheme.textThemeT1.body),
                                TextSpan(
                                  text: history.tinhTrangDescription,
                                  style: context.myTheme.textThemeT1.body
                                      .copyWith(
                                          color: context
                                              .myTheme.colorScheme.primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.numbers,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Tổng số lượng: ",
                                    style: context.myTheme.textThemeT1.body),
                                TextSpan(
                                  text:
                                      history.totalQuantity?.toStringWithInt(),
                                  style: context.myTheme.textThemeT1.body
                                      .copyWith(
                                          color: context
                                              .myTheme.colorScheme.primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (history.tinhTrang != TinhTrangGiaoDich.ChoXacNhan.value)
                      Row(
                        children: [
                          const Icon(
                            Icons.numbers,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Tổng số lượng duyệt: ",
                                      style: context.myTheme.textThemeT1.body),
                                  TextSpan(
                                    text: history.totalApproveQuantity
                                        ?.toStringWithInt(),
                                    style: context.myTheme.textThemeT1.body
                                        .copyWith(
                                            color: context
                                                .myTheme.colorScheme.primary),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        const Icon(
                          Icons.note,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Ghi chú: ",
                                    style: context.myTheme.textThemeT1.body),
                                TextSpan(
                                  text: history.ghiChu,
                                  style: context.myTheme.textThemeT1.body
                                      .copyWith(
                                          color: context
                                              .myTheme.colorScheme.primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VSpacing(),
                    // Wrap(
                    //   spacing: 10,
                    //   runSpacing: 10,
                    //   children: controller.bloodTypes
                    //       .map((e) => BloodTypeWidget(
                    //             title: e.name ?? "",
                    //             size: 50,
                    //             fontSize: 12,
                    //             onTap: () {},
                    //             isActive: () => false,
                    //           ))
                    //       .toList(),
                    // )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                    ),
                    icon: Icon(
                      (history.tinhTrang == TinhTrangGiaoDich.ChoXacNhan.value)
                          ? Icons.edit
                          : Icons.remove_red_eye,
                      size: 20,
                      color: AppColor.mainColor,
                    ),
                    onPressed: () {
                      //
                      controller.updateItem(history);
                    },
                  ),
                  if (history.tinhTrang == TinhTrangGiaoDich.ChoXacNhan.value)
                    IconButton(
                      padding: EdgeInsets.zero,
                      style: IconButton.styleFrom(
                          padding: EdgeInsets.zero, minimumSize: Size.zero),
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: AppColor.mainColor,
                      ),
                      onPressed: () {
                        ///delete
                        controller.deleteItem(history);
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const VSpacing(
        spacing: 20,
      ),
    ));
  }

  Widget buildTabbar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.2),
            blurStyle: BlurStyle.outer)
      ]),
      child: Row(
        children: TinhTrangGiaoDich.values.map((e) {
          final isSelected = e == controller.type;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                controller.changeTab(type: e);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? context.myTheme.colorScheme.primary
                        : null),
                alignment: Alignment.center,
                child: AutoSizeText(
                  e.description,
                  group: controller.autoSizeGroupTab,
                  style: context.myTheme.textThemeT1.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
