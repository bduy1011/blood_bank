import 'package:blood_donation/app/config/routes.dart';
import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:ticker_text/ticker_text.dart';

import '../../../app/theme/icons.dart';
import '../../about/presentation/about_page.dart';
import '../controller/setting_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState
    extends BaseViewStateful<SettingsPage, SettingController> {
  @override
  SettingController dependencyController() {
    // TODO: implement dependencyController
    return SettingController();
  }

  List<Widget> get items => [
        _buildSection(
          AppLocale.myAccount.translate(context),
          [
            menuItem(
              icon: Icons.account_circle_outlined,
              title: AppLocale.accountInformation.translate(context),
              onTap: () {
                ///
                Get.toNamed(Routes.profile);
              },
            ),
            menuItem(
              icon: Icons.password_rounded,
              title: AppLocale.changePassword.translate(context),
              onTap: () {
                ///
                Get.toNamed(Routes.changePassword);
              },
            )
          ],
        ),
        _buildSection(
          AppLocale.appInformation.translate(context),
          [
            menuItem(
              iconPath: AppIcons.icFeedback,
              title: AppLocale.versionInformation.translate(context),
              onTap: () {
                Get.to(() => const AboutPage());
              },
            ),
            menuItem(
              iconPath: AppIcons.icFeedback,
              title: AppLocale.rateUs.translate(context),
              onTap: () {
                controller.reviewAPP();
              },
            ),
          ],
        ),
        _buildSection(
          AppLocale.setup.translate(context),
          [
            menuItem(
              icon: Icons.language,
              title: AppLocale.language.translate(context),
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
            menuItem(
              icon: Icons.logout,
              title: AppLocale.logout.translate(context),
              onTap: () {
                ////
                controller.logout();
              },
            ),
            menuItem(
              icon: Icons.delete_outline,
              title: AppLocale.deleteAccount.translate(context),
              onTap: () {
                ///
                controller.deleteAccount();
              },
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Container(
              alignment: Alignment.topLeft,
              height: Get.height / 2,
              width: Get.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.mainColor,
                    Color.fromARGB(255, 246, 103, 93),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 140,
                          width: 500,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.mainColor,
                                Color.fromARGB(255, 250, 80, 68),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        Container(
                          height: 115,
                          width: Get.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 60,
                      child: Text(
                        AppLocale.settings.translate(context),
                        style: context.myTheme.textThemeT1.header1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                  )),
                              padding: const EdgeInsets.all(20),
                              child: SvgPicture.asset(
                                "assets/icons/ic_home_profile.svg",
                                colorFilter: const ColorFilter.mode(
                                    Colors.red, BlendMode.srcIn),
                                width: 50,
                                height: 50,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Text(
                              controller.appCenter.authentication?.name ?? "",
                              style: context.myTheme.textThemeT1.bigTitle
                                  .copyWith(color: Colors.black),
                            ),

                            //
                            // Text(
                            //   "Mức 2",
                            //   style: context.myTheme.textThemeT1.title
                            //       .copyWith(color: Colors.grey),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items.map((e) => e).toList(),
                      ),
                    ),
                  ),
                  // ListView.separated(
                  //   itemCount: items.length,
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   separatorBuilder: (BuildContext context, int index) {
                  //     return const SizedBox(
                  //       height: 20,
                  //     );
                  //   },
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return items.elementAt(index);
                  //   },
                  // ),
                ),
                Container(
                  height: 70,
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TickerText(
                    // default values
                    // controller: tickerTextController, // this is optional
                    scrollDirection: Axis.horizontal,
                    speed: 20,
                    startPauseDuration: const Duration(seconds: 3),
                    endPauseDuration: const Duration(seconds: 5),
                    returnDuration: const Duration(milliseconds: 800),
                    primaryCurve: Curves.linear,
                    returnCurve: Curves.easeOut,
                    child: Text(
                      AppLocale.thankYouMessage.translate(context),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget groupItem(List<Widget> menuItems) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:
          // Column(
          //   children: [
          //     ...menuItems.map((e) => e),
          //     const SizedBox(
          //       height: 1,
          //       child: Divider(
          //         color: Color(0xFFC4C4C4),
          //         thickness: 1,
          //       ),
          //     ),
          //     const SizedBox(
          //       height: 10,
          //     ),
          //   ],
          // ),

          ListView.separated(
        itemCount: menuItems.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => const SizedBox(
          height: 1,
          child: Divider(
            color: Color(0xFFC4C4C4),
            thickness: 1,
          ),
        ),
        itemBuilder: (context, index) {
          return menuItems.elementAt(index);
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> menuItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        groupItem(menuItems),
      ],
    );
  }

  Widget menuItem({
    String? iconPath,
    IconData? icon,
    String? title,
    Color? iconColor,
    Color? titleColor,
    VoidCallback? onTap,
    bool showTrailing = true,
  }) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: Center(
                  child: (() {
                    if (iconPath != null) {
                      return iconPath.endsWith(".svg")
                          ? SvgPicture.asset(
                              iconPath,
                              width: 20,
                              height: 20,
                            )
                          : Image.asset(
                              iconPath,
                              width: 20,
                              height: 20,
                            );
                    } else if (icon != null) {
                      return Container(
                        width: 25,
                        height: 25,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          icon,
                          color: iconColor,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }()),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  title ?? "",
                  style: context.myTheme.textThemeT1.header2
                      .copyWith(color: titleColor),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              if (showTrailing)
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                )
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocale.language.translate(context)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(AppLocale.english.translate(context)),
                leading: Radio<AppLanguage>(
                  value: AppLanguage.en,
                  groupValue: _getCurrentLanguage(),
                  onChanged: (AppLanguage? value) {
                    if (value != null) {
                      controller.changeLanguage(value);
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(AppLocale.vietnamese.translate(context)),
                leading: Radio<AppLanguage>(
                  value: AppLanguage.vi,
                  groupValue: _getCurrentLanguage(),
                  onChanged: (AppLanguage? value) {
                    if (value != null) {
                      controller.changeLanguage(value);
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppLanguage _getCurrentLanguage() {
    final currentLocale = localization.currentLocale;
    if (currentLocale?.languageCode == 'en') {
      return AppLanguage.en;
    }
    return AppLanguage.vi;
  }
}
