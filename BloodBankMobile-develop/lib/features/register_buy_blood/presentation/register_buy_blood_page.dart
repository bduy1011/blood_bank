import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/home/components/blood_type_widget.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';
import 'package:enhance_expansion_panel/enhance_expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/widgets/select_box.dart';
import '../../../models/dm_don_vi_cap_mau_response.dart';
import '../../../models/giao_dich_template.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../../home/models/home_category.dart';
import '../controller/register_buy_blood_controller.dart';

class RegisterBuyBloodPage extends StatefulWidget {
  const RegisterBuyBloodPage({super.key});

  @override
  State<RegisterBuyBloodPage> createState() => _RegisterBuyBloodPageState();
}

class _RegisterBuyBloodPageState
    extends BaseViewStateful<RegisterBuyBloodPage, RegisterBuyBloodController> {
  @override
  RegisterBuyBloodController dependencyController() {
    // TODO: implement dependencyController
    return RegisterBuyBloodController();
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
              title: Hero(
                tag: HomeCategory.registerBuyBlood.name,
                child: Text(
                  AppLocale.registerBuyBlood.translate(context),
                  style: context.myTheme.textThemeT1.title
                      .copyWith(color: Colors.white),
                ),
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
              //   actions: (controller.giaodichResponse == null)
              //       ? [
              //           IconButton(
              //               onPressed: () async {
              //                 Get.toNamed(Routes.registerBlood);
              //               },
              //               icon: const Icon(
              //                 Icons.history,
              //                 color: Colors.white,
              //               ))
              //         ]
              //       : null,
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
                    _buildDropdown<DmDonViCapMauResponse>(
                      hint: "Đơn vị nhượng máu",
                      list: controller.dmDonViCapMaus ?? [],
                      value: controller.dmDonViCapMauCurrent,
                      onChanged: (dm) {
                        setState(
                          () {
                            controller.dmDonViCapMauCurrent = dm;
                          },
                        );
                      },
                    ),
                    _buildTextField(AppLocale.note.translate(context)),
                    // _buildContent(),
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
      children: controller.giaoDichTemplate?.giaoDichChiTietViews
              ?.map((e) => _buildContentViewItem(e))
              .toList() ??
          [],
    );
  }

  Widget _buildContentViewItem(GiaoDichChiTietViews item) {
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
                (item.giaoDichConViews ?? [])
                    .where((e) => (e.soLuong ?? 0) > 0)
                    .toList(),
                item,
              );
            },
            body: _buildContent(item.giaoDichConViews ?? [], item),
            isExpanded: item.isExpaned,
            canTapOnHeader: controller.isUpdate,
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
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (controller.isUpdate)
                    const SizedBox(
                      width: 40,
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
                          labelText: "Số lượng",
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (!controller.isUpdate)
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: Obx(
                        () => TextFormField(
                          controller: TextEditingController(
                            text: ('${controller.totalDuyet.value}'),
                          ),
                          onChanged: (v) {},
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixStyle:
                                TextStyle(backgroundColor: Colors.grey),
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.grey),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
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
                            labelText: "Duyệt",
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
                  controller.giaodichResponse != null
                      ? "Cập nhật thông tin"
                      : AppLocale.registerBuyBlood.translate(context),
                  style: context.myTheme.textThemeT1.title
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildContent(
      List<GiaoDichConViews> items, GiaoDichChiTietViews giaoDichChiTietViews) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items
            .where((e) => controller.isUpdate || (e.soLuong ?? 0) > 0)
            .map((e) {
          return buildQuantityRow(e, giaoDichChiTietViews);
        }).toList(),
      ),
    );
  }

  Widget _buildContentCollapse(
      List<GiaoDichConViews> items, GiaoDichChiTietViews item) {
    // var sum =
    //     items.fold(0, (total, giaoDich) => (total) + (giaoDich.soLuong ?? 0));
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

  Widget buildQuantityRow(
      GiaoDichConViews item, GiaoDichChiTietViews giaoDichChiTietViews) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Obx(
              () {
                if (item.soLuongObs.value > 0) {}
                return BloodTypeWidget(
                  title: item.maNhomMauDescription ?? "",
                  size: 50,
                  fontSize: 18,
                  isActive: () => (item.soLuongObs.value) > 0,
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
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
                      item.soLuongObs.value = v.toIntOrZero ?? 0;
                      giaoDichChiTietViews.updateTitle();
                      controller.getTotal();
                      controller.getTotalDuyet();
                    },
                    readOnly: !controller.isUpdate,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixStyle:
                          const TextStyle(backgroundColor: Colors.grey),
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      labelText: "SL ≤ ${item.soLuongTon ?? 0}",
                      hintText: "SL ≤ ${item.soLuongTon ?? 0}",
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (!controller.isUpdate)
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: TextEditingController(
                          text: (item.soLuongDuyet ?? 0) > 0
                              ? item.soLuongDuyet?.toString()
                              : " "),
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
                        labelText: "Duyệt",
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

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: !controller.isUpdate,
        initialValue: controller.ghichu,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: controller.isUpdate ? Colors.white : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (v) {
          controller.ghichu = v;
        },
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
          fillColor: controller.isUpdate ? Colors.white : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        readOnly: true,
        onTap: () async {
          if (!controller.isUpdate) {
            return;
          }
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            setState(() {
              controller.date = pickedDate;
            });
            controller.initTonMau();
          }
        },
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String hint,
    required List<T> list,
    required T? value,
    required Function(T?) onChanged,
    bool isRequired = false,
    bool isSearch = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SelectBoxWidget<T>(
        options: list,
        currentValue: value,
        height: 55,
        placeholder: hint,
        hintSearch: "Tìm kiếm",
        isSearch: isSearch,
        onChange: (p0) {
          onChanged.call(p0);
        },
        isRequired: isRequired,
        isDisabled: controller.isUpdate == false,
      ),
    );
  }
}
