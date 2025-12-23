import 'package:blood_donation/features/home/components/blood_type_widget.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';
import 'package:enhance_expansion_panel/enhance_expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../models/giao_dich_template.dart';
import '../../../models/giaodich_response.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../../components/custom_text_button.dart';
import '../controller/approve_buy_blood_controller.dart';

class ApproveRegisterBuyBloodPage extends StatefulWidget {
  const ApproveRegisterBuyBloodPage({
    super.key,
    required this.item,
    required this.itemList,
    required this.controller,
    required this.isEdit,
  });
  final GiaoDichTemplate item;
  final GiaodichResponse itemList;
  final bool isEdit;
  final ApproveBuyBloodController controller;

  @override
  State<ApproveRegisterBuyBloodPage> createState() =>
      _ApproveRegisterBuyBloodPageState();
}

class _ApproveRegisterBuyBloodPageState
    extends State<ApproveRegisterBuyBloodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.itemList.creatorName ?? "").toUpperCase(),
                      style: context.myTheme.textThemeT1.title.copyWith(
                          fontSize: 20,
                          color: context.myTheme.colorScheme.primary),
                    ),
                    const VSpacing(),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Thời gian : ",
                          style: context.myTheme.textThemeT1.title),
                      TextSpan(
                          text: widget.itemList.ngay?.ddmmyyyy,
                          style: context.myTheme.textThemeT1.body)
                    ])),
                    const VSpacing(),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Đơn vị cấp máu: ",
                          style: context.myTheme.textThemeT1.title),
                      TextSpan(
                          text: widget.itemList.donViCapMauName,
                          style: context.myTheme.textThemeT1.body)
                    ])),
                    const VSpacing(),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Ghi chú : ",
                          style: context.myTheme.textThemeT1.title),
                      TextSpan(
                          text: widget.itemList.ghiChu ?? "",
                          style: context.myTheme.textThemeT1.body)
                    ])),
                    const VSpacing(),
                    buildContentViews(),
                  ],
                ),
              ),
            ),
            const VSpacing(
              spacing: 10,
            ),
            buildSum(),
            const VSpacing(
              spacing: 10,
            ),
            //
            if (widget.isEdit)
              Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      title: "Duyệt phiếu",
                      onTap: () {
                        widget.controller
                            .onApprove(widget.item, widget.itemList);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextButton(
                      title: "Từ chối",
                      onTap: () {
                        widget.controller
                            .onCancel(widget.item, widget.itemList);
                      },
                      colors: const [
                        Color.fromARGB(255, 163, 120, 120),
                        Color.fromARGB(255, 210, 159, 159),
                      ],
                    ),
                  ),
                ],
              ),
            VSpacing(
              spacing: 10 + Get.mediaQuery.padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Row buildSum() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              Container(
                width: 80,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: TextEditingController(
                    text: ('${widget.controller.getTotal(widget.item)}'),
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
                width: 80,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: TextEditingController(
                    text: ('${widget.controller.getTotalDuyet(widget.item)}'),
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
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: context.myTheme.colorScheme.appBarBackground,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded)),
      centerTitle: true,
      title: Text(
        widget.isEdit ? "Kiểm duyệt" : "Thông tin chi tiết",
        style: context.myTheme.textThemeT1.title,
      ),
      actions: const [],
    );
  }

  Widget buildContentViews() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.item.giaoDichChiTietViews
              ?.map((e) => _buildContentViewItem(e))
              .toList() ??
          [],
    );
  }

  Widget _buildContentViewItem(GiaoDichChiTietViews item) {
    var ls = (item.giaoDichConViews ?? [])
        .where((e) => (e.soLuong ?? 0) > 0)
        .toList();
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
          if (ls.isNotEmpty)
            EnhanceExpansionPanel(
              arrowColor: Colors.black87,
              arrowPosition: EnhanceExpansionPanelArrowPosition.none,
              headerBuilder: (context, isExpanded) {
                return _buildContentCollapse(
                  ls,
                  item,
                );
              },
              body: _buildContent(item.giaoDichConViews ?? []),
              isExpanded: item.isExpaned,
              canTapOnHeader: false,
            ),
        ],
      ),
    );
  }

  Widget _buildContent(List<GiaoDichConViews> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items.where((e) => (e.soLuong ?? 0) > 0).map((e) {
          return buildQuantityRow(e);
        }).toList(),
      ),
    );
  }

  Widget _buildContentCollapse(
      List<GiaoDichConViews> items, GiaoDichChiTietViews item) {
    var sum =
        items.fold(0, (total, giaoDich) => (total) + (giaoDich.soLuong ?? 0));
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Text(
              "${item.loaiSanPhamDescription}${sum > 0 ? " ($sum)" : ""}",
              style: context.myTheme.textThemeT1.title,
            ),
          ),
          if (item.isExpaned == false)
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((e) {
                  return buildQuantityRow(e);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildQuantityRow(GiaoDichConViews item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: BloodTypeWidget(
              title: item.maNhomMauDescription ?? "",
              size: 50,
              fontSize: 18,
              isActive: () => (item.soLuong ?? 0) > 0,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: TextEditingController(
                        text: (item.soLuong ?? 0) > 0
                            ? item.soLuong?.toString()
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
                      labelText: "Số lượng",
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: TextEditingController(
                        text: (item.soLuongDuyet ?? 0) > 0
                            ? item.soLuongDuyet?.toString()
                            : " "),
                    onChanged: (v) {
                      ///
                      setState(() {
                        item.soLuongDuyet = v.toIntOrZero;
                      });
                    },
                    readOnly: !widget.isEdit,
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
                      labelText: "Duyệt ≤ ${item.soLuongTon ?? 0}",
                      hintText: "Duyệt ≤ ${item.soLuongTon ?? 0}",
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
}
