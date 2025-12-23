import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/models/giaodich_response.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/double_ext.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../app/app_util/enum.dart';
import '../../../core/localization/app_locale.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../../home/models/home_category.dart';
import '../controller/approve_buy_blood_controller.dart';

class ApproveBuyBloodPage extends StatefulWidget {
  const ApproveBuyBloodPage({super.key});

  @override
  State<ApproveBuyBloodPage> createState() => _ApproveBuyBloodPageState();
}

class _ApproveBuyBloodPageState
    extends BaseViewStateful<ApproveBuyBloodPage, ApproveBuyBloodController> {
  @override
  ApproveBuyBloodController dependencyController() {
    // TODO: implement dependencyController
    return ApproveBuyBloodController();
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
          end: Alignment.centerRight,
          begin: Alignment.topLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              buildFilter(context),
              buildTabbar(context),
              const VSpacing(),
              buildContent()
            ],
          ),
        ),
      ),
    );
  }

  Container buildTabbar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.3),
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? context.myTheme.colorScheme.primary
                        : null),
                alignment: Alignment.center,
                child: Text(
                  e.description,
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

  Expanded buildContent() {
    return Expanded(
        child: ListView.separated(
      itemCount: controller.historys.length,
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(
        bottom: Get.mediaQuery.padding.bottom,
      ),
      itemBuilder: (context, index) {
        var history = controller.historys[index];
        return Slidable(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer)
                ]),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  controller.onHaftApprove(context, history);
                },
                child: buildContentItem(history, context),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const VSpacing(
        spacing: 10,
      ),
    ));
  }

  Stack buildContentItem(GiaodichResponse history, BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                                text: history.creatorName,
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
                              style: context.myTheme.textThemeT1.body.copyWith(
                                  color: context.myTheme.colorScheme.primary),
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
                              style: context.myTheme.textThemeT1.body.copyWith(
                                  color: context.myTheme.colorScheme.primary),
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
                              style: context.myTheme.textThemeT1.body.copyWith(
                                  color: context.myTheme.colorScheme.primary),
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
                              style: context.myTheme.textThemeT1.body.copyWith(
                                  color: context.myTheme.colorScheme.primary),
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
                              text: history.totalQuantity?.toStringWithInt(),
                              style: context.myTheme.textThemeT1.body.copyWith(
                                  color: context.myTheme.colorScheme.primary),
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
                                text: history.totalApproveQuantity!
                                    .toStringWithInt(),
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
                              style: context.myTheme.textThemeT1.body.copyWith(
                                  color: context.myTheme.colorScheme.primary),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const VSpacing(),
                // if (history.tinhTrang == TinhTrangGiaoDich.ChoXacNhan.value)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           controller.onApprove(history);
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             gradient: const LinearGradient(
                //               colors: [
                //                 Color(0xFFB22C2D),
                //                 Color.fromARGB(255, 222, 45, 45),
                //               ],
                //               begin: Alignment.bottomCenter,
                //               end: Alignment.topCenter,
                //             ),
                //           ),
                //           child: Text(
                //             "Duyệt",
                //             style: context.myTheme.textThemeT1.header2
                //                 .copyWith(color: Colors.white),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           controller.onCancel(history);
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             gradient: const LinearGradient(
                //               colors: [
                //                 Color.fromARGB(255, 163, 120, 120),
                //                 Color.fromARGB(255, 210, 159, 159),
                //               ],
                //               begin: Alignment.bottomCenter,
                //               end: Alignment.topCenter,
                //             ),
                //           ),
                //           child: Text(
                //             "Từ chối",
                //             style: context.myTheme.textThemeT1.header2
                //                 .copyWith(color: Colors.white),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   top: 0,
        //   child: SizedBox(
        //     width: 30,
        //     height: 45,
        //     child: CheckboxWidget(
        //       text: "",
        //       // value: isSanLocAmTinh,
        //       onChange: (v) {
        //         //
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
  // Row(
  //   children: [
  //     Expanded(
  //       child: Wrap(
  //         spacing: 10,
  //         runSpacing: 10,
  //         children: controller.types.isNotEmpty
  //             ? controller.types
  //                 .map(
  //                   (e) => BloodTypeWidget(
  //                     title: e.name ?? "",
  //                     size: 50,
  //                     fontSize: 12,
  //                     isActive: () => false,
  //                   ),
  //                 )
  //                 .toList()
  //             : [],
  //       ),
  //     ),
  //     const SizedBox(width: 10),
  //     Container(
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         gradient: const LinearGradient(
  //           colors: [
  //             Color(0xFFB22C2D),
  //             Color.fromARGB(255, 222, 45, 45),
  //           ],
  //           begin: Alignment.bottomCenter,
  //           end: Alignment.topCenter,
  //         ),
  //       ),
  //       child: Text(
  //         "Duyệt",
  //         style: context.myTheme.textThemeT1.header2
  //             .copyWith(color: Colors.white),
  //       ),
  //     ),
  //   ],
  // )

  Padding buildFilter(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const VSpacing(),
            buildTime(context),
            const VSpacing(),
            buildSearch(context),
          ],
        ));
  }

  Container buildSearch(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.3),
            blurStyle: BlurStyle.outer)
      ]),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: AppLocale.search.translate(context),
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: Icon(
            Icons.search,
            color: context.myTheme.colorScheme.primary,
            size: 20,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (v) {
          controller.onSearch(v);
        },
      ),
    );
  }

  Row buildTime(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.3),
                      blurStyle: BlurStyle.outer)
                ]),
            child: TextFormField(
              controller:
                  TextEditingController(text: controller.startDate.ddmmyyyy),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_month_rounded,
                  color: context.myTheme.colorScheme.primary,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                isDense: true,
                labelText: "Từ ngày",
              ),
              readOnly: true,
              onTap: () async {
                showBoardDateTimePicker(
                    context: context,
                    pickerType: DateTimePickerType.date,
                    initialDate: controller.startDate,
                    enableDrag: false,
                    options: BoardDateTimeOptions(
                      boardTitleTextStyle: context.myTheme.textThemeT1.body,
                      languages: const BoardPickerLanguages(
                          today: "Hôm nay", tomorrow: "Ngày mai"),
                    )).then((e) {
                  if (e != null) {
                    setState(() {
                      controller.startDate = e;
                    });
                    controller.loadData();
                  }
                });
              },
            ),
          ),
        ),
        const HSpacing(
          spacing: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.3),
                      blurStyle: BlurStyle.outer)
                ]),
            child: TextFormField(
              controller:
                  TextEditingController(text: controller.endDate.ddmmyyyy),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_month_rounded,
                  color: context.myTheme.colorScheme.primary,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                isDense: true,
                labelText: "Đến ngày",
              ),
              readOnly: true,
              onTap: () async {
                showBoardDateTimePicker(
                    context: context,
                    pickerType: DateTimePickerType.date,
                    initialDate: controller.endDate,
                    enableDrag: false,
                    options: BoardDateTimeOptions(
                      boardTitleTextStyle: context.myTheme.textThemeT1.body,
                      languages: const BoardPickerLanguages(
                          today: "Hôm nay", tomorrow: "Ngày mai"),
                    )).then(
                  (e) {
                    if (e != null) {
                      setState(() {
                        controller.endDate = e;
                      });
                      controller.loadData();
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: context.myTheme.colorScheme.appBarBackground,
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
        tag: HomeCategory.approveBuyBlood.name,
        child: Text(
          AppLocale.approveBuyBlood.translate(context),
          style:
              context.myTheme.textThemeT1.title.copyWith(color: Colors.white),
        ),
      ),
      actions: const [],
    );
  }
}
