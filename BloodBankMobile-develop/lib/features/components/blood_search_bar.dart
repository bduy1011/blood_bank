import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BloodSearchBar extends StatelessWidget {
  const BloodSearchBar({
    super.key,
    required this.hintText,
    required this.onChange,
    this.margin,
  });
  final String hintText;
  final Function(String? text) onChange;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 5,
            blurStyle: BlurStyle.outer,
            color: Colors.grey.withOpacity(0.6))
      ]),
      child: TextField(
        onChanged: (text) {
          onChange.call(text);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          hintStyle:
              context.myTheme.textThemeT1.body.copyWith(color: Colors.grey),
          hintText: hintText,
          suffixIconConstraints: const BoxConstraints(maxWidth: 25),
          suffixIcon: SvgPicture.asset(
            "assets/icons/ic_location_search.svg",
            width: 20,
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
