import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:blood_donation/models/province.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';

import '../../../models/district.dart';
import '../../../utils/widget/spacer_widget.dart';

class LocationAndTimeForm extends StatelessWidget {
  const LocationAndTimeForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tỉnh/Thành phố",
          style: context.myTheme.textThemeT1.title,
        ),
        const VSpacing(
          spacing: 10,
        ),
        CustomDropdown<Province>(
          closedHeaderPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          hintText: "Nhập Tỉnh/Thành phố",
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
          onChanged: (p0) {},
          items: const [],
          listItemBuilder: (context, item, isSelected, onItemSelect) {
            return Text(
              item.nameProvince,
              style: context.myTheme.textThemeT1.body,
            );
          },
          headerBuilder: (context, selectedItem, enabled) {
            return Text(
              selectedItem.nameProvince,
              style: context.myTheme.textThemeT1.body,
            );
          },
        ),
        const VSpacing(
          spacing: 20,
        ),
        Text(
          "Huyện/Quận",
          style: context.myTheme.textThemeT1.title,
        ),
        const VSpacing(
          spacing: 10,
        ),
        CustomDropdown<District>(
          closedHeaderPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          hintText: "Nhập Huyện/Quận",
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
          onChanged: (p0) {},
          items: const [],
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
        ),
        const VSpacing(
          spacing: 20,
        ),
        Text(
          "Nhập địa chỉ",
          style: context.myTheme.textThemeT1.title,
        ),
        const VSpacing(
          spacing: 20,
        ),
        Container(
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
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              hintStyle:
                  context.myTheme.textThemeT1.body.copyWith(color: Colors.grey),
              hintText: "Nhập địa chỉ",
            ),
          ),
        ),
        const VSpacing(
          spacing: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                "Từ ngày",
                style: context.myTheme.textThemeT1.title,
              ),
            ),
            const HSpacing(
              spacing: 25,
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
                  onTap: () {
                    showBoardDateTimePicker(
                        context: context,
                        pickerType: DateTimePickerType.date,
                        onResult: (p0) {},
                        options: const BoardDateTimeOptions(
                          languages: BoardPickerLanguages(
                              today: "Hôm nay", tomorrow: "Ngày mai"),
                        ));
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    hintStyle: context.myTheme.textThemeT1.body
                        .copyWith(color: Colors.grey),
                    hintText: "Nhập thời gian",
                  ),
                ),
              ),
            ),
          ],
        ),
        const VSpacing(
          spacing: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                "Đến ngày",
                style: context.myTheme.textThemeT1.title,
              ),
            ),
            const HSpacing(
              spacing: 25,
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
                  onTap: () async {
                    // final result =
                    await showBoardDateTimeMultiPicker(
                      context: context,
                      pickerType: DateTimePickerType.date,
                      onResult: (p0, p1) {},
                    );
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    hintStyle: context.myTheme.textThemeT1.body
                        .copyWith(color: Colors.grey),
                    hintText: "Nhập thời gian",
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
