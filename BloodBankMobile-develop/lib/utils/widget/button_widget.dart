import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';

class AppPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? buttonColor;
  final TextStyle? titleStyle;
  final double? buttonHeight;
  final bool enable;

  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.buttonColor,
    this.buttonHeight,
    this.enable = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? AppDimens.buttonHeight,
      child: Opacity(
          opacity: enable ? 1 : 0.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  buttonColor ?? context.myTheme.colorScheme.primary,
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            onPressed: enable ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style:
                      titleStyle ?? context.myTheme.buttonTitleThemeT1.button,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? titleColor;
  final TextStyle? style;
  final bool enable;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.titleColor,
    this.style,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enable ? onPressed : null,
      child: Text(
        title,
        style: style ??
            context.myTheme.buttonThemeT1.textButton.copyWith(
              color: titleColor ?? context.myTheme.colorScheme.primary,
            ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final bool hasDropShadown;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? shadownColor;
  final double? height;
  final double? width;

  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.hasDropShadown = false,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.shadownColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimens.buttonRadius,
          ),
          boxShadow: hasDropShadown
              ? [
                  BoxShadow(
                    color: shadownColor ?? Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 4,
                  )
                ]
              : null),
      child: SizedBox(
        height: height,
        width: width,
        child: CupertinoButton(
          onPressed: onPressed,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: icon,
        ),
      ),
    );
  }
}
