import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// import '../../models/blood_type.dart';
import '../../models/district.dart';
import '../../models/province.dart';
import '../../utils/widget/spacer_widget.dart';

class BloodFilter extends StatefulWidget {
  const BloodFilter({
    super.key,
    this.startDate,
    this.endDate,
    this.province,
    this.district,
    this.provinces,
    this.districts,
    this.onChanged,
    this.limidDate,
    this.listStatus,
    this.status,
  });
  final int? limidDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final Province? province;
  final List<Province>? provinces;
  final District? district;
  final List<District>? districts;
  final List<String>? listStatus;
  final String? status;
  final Function(DateTime? startDate, DateTime? endDate, Province? province,
      District? district, String? status)? onChanged;

  @override
  State<BloodFilter> createState() => _BloodFilterState();
}

class _BloodFilterState extends State<BloodFilter> {
  DateTime? startDate;
  DateTime? endDate;
  Province? province;
  District? district;
  String? status;
  @override
  void initState() {
    setState(() {
      startDate = widget.startDate;
      endDate = widget.endDate;
      province = widget.province;
      district = widget.district;
      status = widget.status;
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
                if (widget.listStatus?.isNotEmpty == true) ...[
                  const VSpacing(
                    spacing: 10,
                  ),
                  buildStatus(context),
                ],
                if (widget.provinces?.isNotEmpty == true) ...[
                  const VSpacing(
                    spacing: 10,
                  ),
                  buildProvince(context),
                ],
                if (widget.districts?.isNotEmpty == true) ...[
                  const VSpacing(
                    spacing: 10,
                  ),
                  buildDistrict(context),
                ],

                const VSpacing(
                  spacing: 30,
                ),

                // Text(
                //   AppLocale.bloodType.translate(context),
                //   style: context.myTheme.textThemeT1.title,
                // ),
                // const VSpacing(
                //   spacing: 20,
                // ),
                // Wrap(
                //   spacing: 20,
                //   runSpacing: 20,
                //   children: BloodType.values
                //       .map((e) => BloodTypeWidget(
                //             isActive: bloodTypes.contains(e),
                //             title: e.title,
                //             size: 50,
                //             onTap: () {
                //               if (bloodTypes.contains(e)) {
                //                 bloodTypes.remove(e);
                //               } else {
                //                 bloodTypes.add(e);
                //               }
                //               setState(() {});
                //             },
                //           ))
                //       .toList(),
                // )
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
            widget.onChanged
                ?.call(startDate, endDate, province, district, status);
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
            "Áp dụng",
            style:
                context.myTheme.textThemeT1.title.copyWith(color: Colors.white),
          )),
    );
  }

  CustomDropdown<District> buildDistrict(BuildContext context) {
    return CustomDropdown<District>.searchRequest(
      closedHeaderPadding:
          const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      hintText: AppLocale.enterDistrict.translate(context),
      initialItem: district,
      decoration: CustomDropdownDecoration(
          hintStyle:
              context.myTheme.textThemeT1.body.copyWith(color: Colors.grey),
          closedBorderRadius: BorderRadius.circular(10),
          closedShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 5,
                blurStyle: BlurStyle.outer,
                color: Colors.grey.withOpacity(0.6))
          ],
          headerStyle: context.myTheme.textThemeT1.body),
      onChanged: (p0) {
        setState(() {
          district = p0;
        });
        // widget.onChanged?.call(startDate, endDate, province, district);
      },
      items: widget.districts
              ?.where((e) => e.codeProvince == province?.codeProvince)
              .toList() ??
          [],
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(
          item.nameDistrict,
          style: context.myTheme.textThemeT1.body,
        );
      },
      headerBuilder: (context, selectedItem, enabled) {
        return Text(
          selectedItem.nameDistrict,
          style: context.myTheme.textThemeT1.body,
        );
      },
      futureRequest: (String search) async {
        var ls = widget.districts
                ?.where((e) => e.codeProvince == province?.codeProvince)
                .toList() ??
            [];
        return ls
            .where((e) => e.nameDistrict.toLowerCase().contains(search) == true)
            .toList();
      },
    );
  }

  CustomDropdown<String> buildStatus(BuildContext context) {
    return CustomDropdown<String>(
      closedHeaderPadding:
          const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      hintText: "Chọn tình trạng",
      decoration: CustomDropdownDecoration(
          hintStyle:
              context.myTheme.textThemeT1.body.copyWith(color: Colors.grey),
          closedBorderRadius: BorderRadius.circular(10),
          closedShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 5,
                blurStyle: BlurStyle.outer,
                color: Colors.grey.withOpacity(0.6))
          ],
          headerStyle: context.myTheme.textThemeT1.body),
      onChanged: (p0) {
        setState(() {
          status = p0;
        });
        // widget.onChanged?.call(startDate, endDate, province, district);
      },
      items: widget.listStatus,
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(
          item,
          style: context.myTheme.textThemeT1.body,
        );
      },
      initialItem: status,
      headerBuilder: (context, selectedItem, enabled) {
        return Text(
          selectedItem,
          style: context.myTheme.textThemeT1.body,
        );
      },
    );
  }

  CustomDropdown<Province> buildProvince(BuildContext context) {
    return CustomDropdown<Province>.searchRequest(
      closedHeaderPadding:
          const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      hintText: AppLocale.enterProvinceCity.translate(context),
      decoration: CustomDropdownDecoration(
          hintStyle:
              context.myTheme.textThemeT1.body.copyWith(color: Colors.grey),
          closedBorderRadius: BorderRadius.circular(10),
          closedShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 5,
                blurStyle: BlurStyle.outer,
                color: Colors.grey.withOpacity(0.6))
          ],
          headerStyle: context.myTheme.textThemeT1.body),
      onChanged: (p0) {
        setState(() {
          province = p0;
          district = null;
        });
        // widget.onChanged?.call(startDate, endDate, province, district);
      },
      items: widget.provinces,
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(
          item.nameProvince,
          style: context.myTheme.textThemeT1.body,
        );
      },
      initialItem: province,
      headerBuilder: (context, selectedItem, enabled) {
        return Text(
          selectedItem.nameProvince,
          style: context.myTheme.textThemeT1.body,
        );
      },
      futureRequest: (String search) async {
        return widget.provinces
                ?.where((e) =>
                    e.nameProvince.toLowerCase().contains(search) == true)
                .toList() ??
            [];
      },
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
                    // minimumDate: widget.limidDate != null
                    //     ? DateTime.now()
                    //         .subtract(Duration(days: widget.limidDate!))
                    //     : null,
                    maximumDate: widget.limidDate != null
                        ? DateTime.now().add(Duration(days: widget.limidDate!))
                        : null,
                    onResult: (BoardDateResult p0) {
                      ///
                      setState(() {
                        startDate = DateTime(p0.year, p0.month, p0.day);
                      });
                      // widget.onChanged
                      //     ?.call(startDate, endDate, province, district);
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
                  // minimumDate: widget.limidDate != null
                  //     ? DateTime.now()
                  //         .subtract(Duration(days: widget.limidDate!))
                  //     : null,
                  maximumDate: widget.limidDate != null
                      ? DateTime.now().add(Duration(days: widget.limidDate!))
                      : null,
                  onResult: (BoardDateResult p0) {
                    ///
                    setState(() {
                      endDate = DateTime(p0.year, p0.month, p0.day);
                    });
                  },
                  options: BoardDateTimeOptions(
                    languages: BoardPickerLanguages(
                      today: AppLocale.today.translate(context),
                      tomorrow: AppLocale.tomorrow.translate(context),
                    ),
                    pickerFormat: PickerFormat.dmy,
                  ),
                );
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
