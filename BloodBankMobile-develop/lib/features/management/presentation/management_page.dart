import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/features/home/components/blood_type_widget.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';
import 'package:enhance_expansion_panel/enhance_expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/cau_hinh_ton_kho_view.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../controller/management_controller.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState
    extends BaseViewStateful<ManagementPage, ManagementController> {
  @override
  ManagementController dependencyController() {
    // TODO: implement dependencyController
    return ManagementController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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
                "Quản lý tồn kho",
                style: context.myTheme.textThemeT1.title
                    .copyWith(color: Colors.white),
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
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16)
                        .copyWith(bottom: Get.mediaQuery.padding.bottom),
                child: Column(
                  children: [
                    _buildDatePicker(context, 'Ngày'),
                    buildContentViews(),
                    const Divider(),
                    buildButton(context),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildContentViews() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: controller.cauHinhTonKho?.cauHinhTonKhoChiTietViews
              ?.map((e) => _buildContentViewItem(e))
              .toList() ??
          [],
    );
  }

  Widget _buildContentViewItem(CauHinhTonKhoChiTietViews item) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: EnhanceExpansionPanelList(
        animationDuration: const Duration(milliseconds: 800),
        expandedHeaderPadding: EdgeInsets.zero,
        materialGapSize: 0,
        expansionCallback: (panelIndex, expanded) {
          setState(() {
            item.isExpaned = !(item.isExpaned == true);
          });
        },
        children: [
          EnhanceExpansionPanel(
            arrowColor: Colors.black87,
            arrowPosition: EnhanceExpansionPanelArrowPosition.none,
            headerBuilder: (context, isExpanded) {
              return _buildContentCollapse(
                (item.cauHinhTonKhoChiTietConViews ?? [])
                    .where((e) => (e.soLuong ?? 0) > 0)
                    .toList(),
                item,
              );
            },
            body: _buildContent(item.cauHinhTonKhoChiTietConViews ?? [], item),
            isExpanded: item.isExpaned,
            canTapOnHeader: true,
          ),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VSpacing(),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.4),
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 1,
                      )
                    ]),
                child: const Text(
                  'Tổng: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (controller.isUpdate)
                    const SizedBox(
                      width: 50,
                    ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Obx(
                      () => TextFormField(
                        controller: TextEditingController(
                          text: ('${controller.total.value}'),
                        ),
                        onChanged: (v) {},
                        readOnly: !controller.isUpdate,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixStyle: TextStyle(backgroundColor: Colors.grey),
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          fillColor: Colors.white,
                          labelText: "Số lượng",
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Obx(
                      () => TextFormField(
                        controller: TextEditingController(
                          text: ('${controller.totalBooking.value}'),
                        ),
                        onChanged: (v) {},
                        readOnly: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixStyle: TextStyle(backgroundColor: Colors.grey),
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          fillColor: Colors.white,
                          labelText: "Số lượng đặt",
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (controller.isUpdate)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (controller.isUpdate) {
                    controller.onSubmit();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      !controller.isUpdate ? AppColor.grey : AppColor.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40,
                  ),
                ),
                child: Text(
                  "Cập nhật thông tin",
                  style: context.myTheme.textThemeT1.title
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildContent(List<CauHinhTonKhoChiTietConViews> items,
      CauHinhTonKhoChiTietViews cauHinhTonKhoChiTiet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items
            .where((e) => controller.isUpdate || (e.soLuong ?? 0) > 0)
            .map((e) {
          return buildQuantityRow(e, cauHinhTonKhoChiTiet);
        }).toList(),
      ),
    );
  }

  Widget _buildContentCollapse(List<CauHinhTonKhoChiTietConViews> items,
      CauHinhTonKhoChiTietViews item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Obx(
              () => Text(
                item.title.value,
                style: context.myTheme.textThemeT1.title,
              ),
            ),
          ),
          if (item.isExpaned == false)
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((e) {
                  return buildQuantityRow(e, item);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildQuantityRow(CauHinhTonKhoChiTietConViews item,
      CauHinhTonKhoChiTietViews cauHinhTonKhoChiTiet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: BloodTypeWidget(
              title: item.maNhomMauDescription ?? "",
              size: 50,
              fontSize: 18,
              isActive: () => true,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (controller.isUpdate)
                  const SizedBox(
                    width: 40,
                  ),
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: TextEditingController(
                        text: (item.soLuong ?? 0) > 0
                            ? item.soLuong?.toString()
                            : " "),
                    onChanged: (v) {
                      item.soLuong = v.toIntOrZero;
                      cauHinhTonKhoChiTiet.updateTitle();
                      controller.getTotal();
                    },
                    readOnly: !controller.isUpdate,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixStyle: TextStyle(backgroundColor: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      labelText: "Số lượng",
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: TextEditingController(
                        text: (item.soLuongDuocBooking ?? 0) > 0
                            ? item.soLuongDuocBooking?.toString()
                            : " "),
                    onChanged: (v) {
                      item.soLuongDuocBooking = v.toIntOrZero;
                      cauHinhTonKhoChiTiet.updateTitle();
                      controller.getTotalBooking();
                    },
                    readOnly: !controller.isUpdate,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixStyle: TextStyle(backgroundColor: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      labelText: "Số lượng đặt",
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller:
            TextEditingController(text: controller.date.dateTimeHourString),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          suffixIcon: const Icon(Icons.calendar_today, color: Colors.red),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            controller.onChangeDate(pickedDate);
          }
        },
      ),
    );
  }
}
