import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.onTap,
    this.colors,
  });
  final String title;
  final Function()? onTap;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          maxWidth: 400, minWidth: 300, minHeight: 45, maxHeight: 45),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
              colors:
                  colors ?? [Colors.red, context.myTheme.colorScheme.primary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                title,
                style: context.myTheme.textThemeT1.title
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
