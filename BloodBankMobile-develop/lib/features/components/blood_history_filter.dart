import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/blood_type.dart';
import '../../utils/widget/spacer_widget.dart';
import '../home/components/blood_type_widget.dart';

class BloodHistoryFilter extends StatefulWidget {
  const BloodHistoryFilter({
    super.key,
    this.startDate,
    this.endDate,
    this.onChanged,
    this.isSanLocAmTinh,
    this.isSanLocDuongTinh,
    this.isSanLocKhongXacDinh,
    this.maNhomMaus,
    this.bloodTypes,
  });
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isSanLocAmTinh;
  final bool? isSanLocDuongTinh;
  final bool? isSanLocKhongXacDinh;
  final List<String>? maNhomMaus;
  final List<BloodType>? bloodTypes;
  final Function(
    DateTime? startDate,
    DateTime? endDate,
    bool? isSanLocAmTinh,
    bool? isSanLocDuongTinh,
    bool? isSanLocKhongXacDinh,
    List<String>? maNhomMaus,
  )? onChanged;

  @override
  State<BloodHistoryFilter> createState() => _BloodHistoryFilterState();
}

class _BloodHistoryFilterState extends State<BloodHistoryFilter> {
  DateTime? startDate;
  DateTime? endDate;
  bool? isSanLocAmTinh;
  bool? isSanLocDuongTinh;
  bool? isSanLocKhongXacDinh;
  List<String>? maNhomMaus;
  @override
  void initState() {
    setState(() {
      startDate = widget.startDate;
      endDate = widget.endDate;
      isSanLocAmTinh = widget.isSanLocAmTinh;
      isSanLocDuongTinh = widget.isSanLocDuongTinh;
      isSanLocKhongXacDinh = widget.isSanLocKhongXacDinh;
      maNhomMaus = widget.maNhomMaus;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_rounded)),
            Center(
              child: Text(
                AppLocale.filter.translate(context),
                style: context.myTheme.textThemeT1.title,
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDate(context),
                const VSpacing(
                  spacing: 10,
                ),
                // CheckboxWidget(
                //   text: "Sàn lọc âm tính",
                //   value: isSanLocAmTinh,
                //   onChange: (v) {
                //     setState(() {
                //       isSanLocAmTinh = v;
                //     });
                //     widget.onChanged?.call(startDate, endDate, isSanLocAmTinh,
                //         isSanLocDuongTinh, isSanLocKhongXacDinh, maNhomMaus);
                //   },
                // ),
                // CheckboxWidget(
                //   text: "Sàn lọc dương tính",
                //   value: isSanLocDuongTinh,
                //   onChange: (v) {
                //     setState(() {
                //       isSanLocDuongTinh = v;
                //     });
                //     widget.onChanged?.call(startDate, endDate, isSanLocAmTinh,
                //         isSanLocDuongTinh, isSanLocKhongXacDinh, maNhomMaus);
                //   },
                // ),
                // CheckboxWidget(
                //   text: "Sàn lọc không xác định",
                //   value: isSanLocKhongXacDinh,
                //   onChange: (v) {
                //     setState(() {
                //       isSanLocKhongXacDinh = v;
                //     });
                //     widget.onChanged?.call(startDate, endDate, isSanLocAmTinh,
                //         isSanLocDuongTinh, isSanLocKhongXacDinh, maNhomMaus);
                //   },
                // ),
                // const VSpacing(
                //   spacing: 10,
                // ),
                Text(
                  AppLocale.bloodType.translate(context),
                  style: context.myTheme.textThemeT1.title,
                ),
                const VSpacing(
                  spacing: 10,
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: widget.bloodTypes
                          ?.map((e) => BloodTypeWidget(
                                isActive: () =>
                                    maNhomMaus?.contains(e.name) == true,
                                title: e.name ?? "",
                                size: 50,
                                onTap: () {
                                  if (maNhomMaus?.contains(e.name) == true) {
                                    maNhomMaus?.removeWhere((m) => m == e.name);
                                  } else {
                                    maNhomMaus?.add(e.name ?? "");
                                  }
                                  setState(() {});
                                  // widget.onChanged?.call(
                                  //     startDate,
                                  //     endDate,
                                  //     isSanLocAmTinh,
                                  //     isSanLocDuongTinh,
                                  //     isSanLocKhongXacDinh,
                                  //     maNhomMaus);
                                },
                              ))
                          .toList() ??
                      [],
                ),
                const VSpacing(
                  spacing: 30,
                ),
                buildButtonApply(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonApply() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            ///
            widget.onChanged?.call(startDate, endDate, isSanLocAmTinh,
                isSanLocDuongTinh, isSanLocKhongXacDinh, maNhomMaus);
            Get.back(result: true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 229, 59, 59),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 40,
            ),
          ),
          child: Text(
            AppLocale.apply.translate(context),
            style:
                context.myTheme.textThemeT1.title.copyWith(color: Colors.white),
          )),
    );
  }

  Row buildDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 5,
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey.withOpacity(0.6))
                ]),
            child: TextField(
              controller: TextEditingController(
                  text: startDate != null
                      ? DateFormat("dd/MM/yyyy").format(startDate!)
                      : ""),
              readOnly: true,
              onTap: () {
                showBoardDateTimePicker(
                    context: context,
                    pickerType: DateTimePickerType.date,
                    initialDate: startDate,
                    onResult: (BoardDateResult p0) {
                      ///
                      setState(() {
                        startDate = DateTime(p0.year, p0.month, p0.day);
                      });
                      // widget.onChanged?.call(startDate, endDate, isSanLocAmTinh,
                      //     isSanLocDuongTinh, isSanLocKhongXacDinh, maNhomMaus);
                    },
                    options: BoardDateTimeOptions(
                      languages: BoardPickerLanguages(
                          today: AppLocale.today.translate(context),
                          tomorrow: AppLocale.tomorrow.translate(context)),
                      pickerFormat: PickerFormat.dmy,
                    ));
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                hintStyle: context.myTheme.textThemeT1.body
                    .copyWith(color: Colors.grey),
                hintText: AppLocale.fromDate.translate(context),
              ),
            ),
          ),
        ),
        const HSpacing(
          spacing: 20,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 5,
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey.withOpacity(0.6))
                ]),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(
                  text: endDate != null
                      ? DateFormat("dd/MM/yyyy").format(endDate!)
                      : ""),
              onTap: () async {
                // final result =
                // await showBoardDateTimeMultiPicker(
                //   context: context,
                //   pickerType: DateTimePickerType.date,
                //   onResult: (p0, p1) {},
                // );
                showBoardDateTimePicker(
                    context: context,
                    pickerType: DateTimePickerType.date,
                    initialDate: endDate,
                    onResult: (BoardDateResult p0) {
                      ///
                      setState(() {
                        endDate = DateTime(p0.year, p0.month, p0.day);
                      });
                      // widget.onChanged?.call(startDate, endDate, isSanLocAmTinh,
                      //     isSanLocDuongTinh, isSanLocKhongXacDinh, maNhomMaus);
                    },
                    options: BoardDateTimeOptions(
                      languages: BoardPickerLanguages(
                          today: AppLocale.today.translate(context),
                          tomorrow: AppLocale.tomorrow.translate(context)),
                      pickerFormat: PickerFormat.dmy,
                    ));
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                hintStyle: context.myTheme.textThemeT1.body
                    .copyWith(color: Colors.grey),
                hintText: AppLocale.toDay.translate(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
