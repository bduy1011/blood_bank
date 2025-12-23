import 'package:blood_donation/app/app_util/enum.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/models/ward.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/colors.dart';
import '../../../base/widgets/select_box.dart';
import '../../../models/district.dart';
import '../../../models/province.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/redirect_to_google_utils.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../controller/register_donate_blood_controller.dart';

class RegisterDonateBloodPageSecond extends StatefulWidget {
  const RegisterDonateBloodPageSecond({super.key, required this.state});
  final RegisterDonateBloodController state;

  @override
  State<RegisterDonateBloodPageSecond> createState() =>
      _RegisterDonateBloodPageSecondState();
}

class _RegisterDonateBloodPageSecondState
    extends State<RegisterDonateBloodPageSecond> {
  @override
  void didUpdateWidget(covariant RegisterDonateBloodPageSecond oldWidget) {
    // TODO: implement didUpdateWidget
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        height: context.screenHeight,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20)
              .copyWith(bottom: Get.mediaQuery.padding.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfo(context),
              const SizedBox(height: 20),
              Form(
                key: widget.state.formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      label: AppLocale.fullname.translate(context),
                      isEnabled: widget
                              .state.appCenter.authentication?.dmNguoiHienMau ==
                          null,
                      controller: widget.state.nameController,
                      onChanged: (value) {
                        widget.state.updateProfile(name: value);
                      },
                      isRequired: true,
                    ),
                    _buildTextField(
                      label: "Năm sinh",
                      isEnabled: widget
                              .state.appCenter.authentication?.dmNguoiHienMau ==
                          null,
                      controller: widget.state.namSinhController,
                      onChanged: (value) {
                        widget.state.updateProfile(
                          namSinh: value.toIntOrNull,
                        );
                      },
                      isRequired: true,
                    ),
                    buildDropdown<String>(
                      hint: "Giới tính",
                      list: ["Nam", "Nữ"],
                      // getValue: (province) => province.codeProvince,
                      // getLabel: (province) => province.nameProvince,
                      onChanged: (value) {
                        setState(() {
                          widget.state.updateProfile(
                            gioiTinh: value == "Nam",
                          );
                        });
                      },
                      value:
                          (widget.state.registerDonationBlood.gioiTinh == true)
                              ? "Nam"
                              : (widget.state.registerDonationBlood.gioiTinh ==
                                      false)
                                  ? "Nữ"
                                  : null,
                      isRequired: true,
                      isSearch: false,
                      getValue: () =>
                          (widget.state.registerDonationBlood.gioiTinh == true)
                              ? "Nam"
                              : (widget.state.registerDonationBlood.gioiTinh ==
                                      false)
                                  ? "Nữ"
                                  : null,
                    ),
                    _buildTextField(
                      label: AppLocale.idCard.translate(context),
                      controller: widget.state.idCardController,
                      isEnabled: widget.state.appCenter.authentication
                              ?.dmNguoiHienMau?.cmnd?.isNotEmpty !=
                          true,
                      onChanged: (value) {
                        widget.state.updateProfile(idCard: value);
                      },
                      isRequired: true,
                    ),
                    _buildTextField(
                      label: AppLocale.phoneNumber.translate(context),
                      controller: widget.state.phoneNumberController,
                      onChanged: (value) {
                        widget.state.updateProfile(soDT: value);
                      },
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildDatePicker(context, 'Ngày giờ dự kiến đến'),
                    _buildTextField(
                      label: "Địa chỉ liên hệ",
                      controller: widget.state.diaChiController,
                      onChanged: (value) {
                        widget.state.updateProfile(diaChiLienLac: value);
                      },
                      isRequired: true,
                      maxLength: 100,
                    ),
                    buildDropdown<Province>(
                      hint: AppLocale.provinceCity.translate(context),
                      list: widget.state.provinces,
                      // getValue: (province) => province.codeProvince,
                      // getLabel: (province) => province.nameProvince,
                      onChanged: (value) {
                        setState(() {
                          widget.state.codeProvince = value;
                          widget.state.updateProfile(
                            codeProvince: value?.codeProvince,
                            nameProvince: value?.nameProvince,
                          );
                          widget.state.codeDistrict = null;
                          widget.state.codeWard = null;
                        });
                      },
                      value: widget.state.codeProvince,
                      isRequired: true,
                      getValue: () => widget.state.codeProvince,
                    ),
                    buildDropdown<District>(
                      hint: AppLocale.district.translate(context),
                      list: widget.state.districts
                          .where(
                            (element) =>
                                element.codeProvince ==
                                widget.state.codeProvince?.codeProvince,
                          )
                          .toList(),
                      // getValue: (district) => district.codeDistrict,
                      // getLabel: (district) => district.nameDistrict,
                      onChanged: (value) {
                        setState(() {
                          widget.state.updateProfile(
                            codeDistrict: value?.codeDistrict,
                            nameDistrict: value?.nameDistrict,
                          );
                          widget.state.codeDistrict = value;
                          widget.state.codeWard = null;
                        });
                      },
                      value: widget.state.codeDistrict,
                      isRequired: false,
                      getValue: () => widget.state.codeDistrict,
                    ),
                    buildDropdown<Ward>(
                      hint: AppLocale.ward.translate(context),
                      list: widget.state.wards
                          .where(
                            (element) =>
                                element.codeDistrict ==
                                widget.state.codeDistrict?.codeDistrict,
                          )
                          .toList(),
                      // getValue: (ward) => ward.codeWards,
                      // getLabel: (ward) => ward.nameWards,
                      onChanged: (value) {
                        setState(() {
                          widget.state.codeWard = value;
                          widget.state.updateProfile(
                            codeWard: value?.codeDistrict,
                            nameWard: value?.nameWards,
                          );
                        });
                      },
                      value: widget.state.codeWard,
                      isRequired: false,
                      getValue: () => widget.state.codeWard,
                    ),
                    _buildTextField(
                      label: "Email",
                      controller: widget.state.emailController,
                      onChanged: (value) {
                        widget.state.updateProfile(email: value);
                      },
                      maxLength: 50,
                    ),
                    _buildTextField(
                      label: "Nghề nghiệp",
                      controller: widget.state.ngheNghiepController,
                      onChanged: (value) {
                        widget.state.updateProfile(ngheNghiep: value);
                      },
                      maxLength: 50,
                    ),
                    _buildTextField(
                      label: "Công ty",
                      controller: widget.state.coQuanController,
                      onChanged: (value) {
                        widget.state.updateProfile(coQuan: value);
                      },
                      maxLength: 50,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 229, 59, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 15,
                        right: 10,
                      ),
                    ),
                    onPressed: () {
                      widget.state.updateNextPage(3);
                    },
                    child: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocale.next.translate(context),
                            style: context.myTheme.textThemeT1.title
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 5),
          child: Text(
            'Bạn đang đăng ký hiến ${widget.state.event?.loaiMau == LoaiMau.TieuCau.value ? "tiểu cầu" : "máu"} tại:',
            style: context.myTheme.textThemeT1.bigTitle
                .copyWith(color: Colors.black),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColor.mainColor),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                widget.state.event?.diaDiemToChuc ?? "",
                style: context.myTheme.textThemeT1.title
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.access_time, color: AppColor.mainColor),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                'Thời gian từ ${widget.state.event?.ngayGio != null ? DateFormat("HH:mm").format(widget.state.event!.ngayGio!) : ""} ngày ${widget.state.event?.ngayGio != null ? DateFormat("dd/MM/yyyy").format(widget.state.event!.ngayGio!) : ""}',
                style: context.myTheme.textThemeT1.title
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (widget.state.event?.googleMapLink?.isNotEmpty == true) {
                ProcessWebviewDialog.instance.openGoogleMapRoadToUrlAddress(
                    widget.state.event?.googleMapLink ?? "");
              } else {
                AppUtils.instance.showToast("Không tìm thấy đường đi");
              }
            },
            child: Container(
              padding: const EdgeInsets.only(top: 5),
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocale.road.translate(context),
                    style: const TextStyle(color: Color(0xff0020aa)),
                  ),
                  const HSpacing(
                    spacing: 4,
                  ),
                  const Icon(
                    Icons.location_on,
                    color: Color(0xff0020aa),
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildDropdown<T>({
    required String hint,
    required List<T> list,
    required T? value,
    required Function(T?) onChanged,
    bool isRequired = false,
    bool isSearch = true,
    required T? Function() getValue,
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
        validator: isRequired
            ? (v) {
                // print("value: $hint $value ${isRequired && value == null}");
                if (isRequired && getValue.call() == null) {
                  return "Vui lòng chọn $hint";
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    bool isRequired = false,
    bool isEnabled = true,
    TextInputType? keyboardType,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: isRequired
            ? (value) {
                if (isRequired && value?.trim().isNotEmpty != true) {
                  return "Vui lòng nhập $label";
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          // labelText: label,
          label: label.isEmpty
              ? null
              : RichText(
                  text: TextSpan(
                    text: label,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    children: [
                      if (isRequired)
                        const TextSpan(
                          text: " *",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
          filled: true,
          fillColor: isEnabled == true ? Colors.white : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
        onChanged: onChanged,
        maxLength: maxLength,
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    String label, {
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: TextEditingController(
            text: widget.state.registerDonationBlood.ngay != null
                ? widget.state.registerDonationBlood.ngay!.dateTimeHourString
                : "Chọn ngày giờ"),
        decoration: InputDecoration(
          // labelText: label,
          label: label.isEmpty
              ? null
              : RichText(
                  text: TextSpan(
                    text: label,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    children: [
                      if (isRequired)
                        const TextSpan(
                          text: " *",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
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
          var initialTime =
              widget.state.registerDonationBlood.ngay ?? DateTime.now();
          TimeOfDay? pickedDate = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: initialTime.hour, minute: initialTime.minute));
          if (pickedDate != null) {
            setState(() {
              var dateTime = DateTime(initialTime.year, initialTime.month,
                  initialTime.day, pickedDate.hour, pickedDate.minute);
              widget.state.updateProfile(date: dateTime);
            });
          }
        },
      ),
    );
  }
}
