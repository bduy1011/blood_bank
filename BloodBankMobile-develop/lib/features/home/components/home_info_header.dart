import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/widget/spacer_widget.dart';
import 'blood_type_widget.dart';

class HomeInfoHeader extends StatelessWidget {
  const HomeInfoHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CouponCard(
        curveAxis: Axis.vertical,
        shadow: BoxShadow(
          blurRadius: 5,
          color: Colors.grey.withOpacity(0.7),
          blurStyle: BlurStyle.outer,
          spreadRadius: 5,
        ),
        firstChild: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BloodTypeWidget(
                    title: "A+",
                    isActive: () => true,
                    size: 30,
                  ),
                  Text(
                    AppLocale.bloodType.translate(context),
                    style: context.myTheme.textThemeT1.title
                        .copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            Divider(
                color: context.myTheme.colorScheme.primary.withOpacity(0.2),
                height: 0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "2",
                    style: context.myTheme.textThemeT1.title.copyWith(
                        fontSize: 30,
                        color: context.myTheme.colorScheme.primary),
                  ),
                  Text(
                    AppLocale.times.translate(context),
                    style: context.myTheme.textThemeT1.title
                        .copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        secondChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nguyễn Thiện Quang",
                    style: context.myTheme.textThemeT1.title,
                  ),
                  const VSpacing(),
                  Text(
                    "17/03/1997",
                    style: context.myTheme.textThemeT1.body,
                  ),
                ],
              )),
              Container(
                decoration: BoxDecoration(
                  color: context.myTheme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  "assets/icons/ic_home_profile.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
              )
            ],
          ),
        ));
  }
}
