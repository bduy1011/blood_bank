import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

class BloodTypeWidget extends StatelessWidget {
  const BloodTypeWidget(
      {super.key,
      required this.isActive,
      required this.title,
      this.size = 35,
      this.onTap,
      this.fontSize = 16});
  final bool Function() isActive;
  final String title;
  final double size;
  final double fontSize;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: isActive.call()
                  ? context.myTheme.colorScheme.primary
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.4),
                  blurStyle: BlurStyle.outer,
                  spreadRadius: 1,
                )
              ]),
          child: Text(
            title,
            style: context.myTheme.textThemeT1.title.copyWith(
                color: isActive.call()
                    ? Colors.white
                    : context.myTheme.colorScheme.primary,
                fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
