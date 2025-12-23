import 'package:blood_donation/models/blood_type.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/widget/spacer_widget.dart';
import '../../components/custom_text_button.dart';
import 'blood_type_quantity_form.dart';

class RegisterBloodForm extends StatefulWidget {
  const RegisterBloodForm({super.key, required this.types});
  final List<BloodType> types;
  @override
  State<RegisterBloodForm> createState() => _RegisterBloodFormState();
}

class _RegisterBloodFormState extends State<RegisterBloodForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Đăng ký",
              style: context.myTheme.textThemeT1.title,
            ),
          ),
          const VSpacing(
            spacing: 30,
          ),
          Expanded(
            child: BloodTypeQuantityForm(
              types: widget.types,
            ),
          ),
          const VSpacing(),
          const CustomTextButton(title: "Tiếp tục"),
          const VSpacing(),
        ],
      ),
    );
  }
}
