import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/app/app_page/controller/app_page_controller.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/features/splash/splash_page.dart';
import 'package:blood_donation/models/authentication.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../features/home/models/navigation_type.dart';
import '../../models/user_role.dart';
import '../app_util/app_state.dart';
import '../config/routes.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends BaseViewStateful<AppPage, AppPageController> {
  _AppPageState() : super(isReusable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.appCenter.init(context: context);
  }

  @override
  AppPageController dependencyController() {
    // TODO: implement dependencyController
    return AppPageController();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.appCenter.state.status.value) {
        case PageStatus.loading:
          return const SplashPage();
        case PageStatus.idle:
          return Scaffold(
            backgroundColor: Colors.white,
            body: controller.routes[controller.activeIndex],
            floatingActionButton: GestureDetector(
              onTap: () {
                setState(() {
                  //controller.activeIndex = 4;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: controller.activeIndex == 4 ||
                                controller.activeIndex == 0
                            ? Colors.red
                            : Colors.black54,
                        width: 2),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer)
                    ]),
                child: Image.asset(
                  controller.activeIndex == 4 || controller.activeIndex == 0
                      ? "assets/icons/app_icon_circle.png"
                      : "assets/icons/app_icon_circle_bw.png",
                  width: 60,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _buildBottomNavigationBar(context),
          );

        case PageStatus.error:
          return Container();
      }
    });
  }

  AnimatedBottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: NavigationType.values.length,
      height: 60,
      tabBuilder: (index, isActive) {
        final item = NavigationType.values[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.icon,
              width: 20,
              height: 20,
              fit: BoxFit.fitHeight,
              colorFilter: isActive
                  ? ColorFilter.mode(
                      context.myTheme.colorScheme.primary, BlendMode.srcIn)
                  : null,
            ),
            Container(
              alignment: Alignment.center,
              child: AutoSizeText(
                item.title(context),
                group: controller.bottomTextGroup,
                style: context.myTheme.textThemeT1.body.copyWith(
                    color: isActive
                        ? context.myTheme.colorScheme.primary
                        : Colors.black,
                    fontSize: 14),
              ),
            ),
          ],
        );
      },
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      shadow: BoxShadow(blurRadius: 6, color: Colors.grey.withOpacity(0.25)),
      activeIndex: controller.activeIndex,
      onTap: (index) {
        final type = NavigationType.values[index];
        switch (type) {
          case NavigationType.register:
            if (controller.appCenter.authentication!.role ==
                UserRole.hospital) {
              Get.toNamed(Routes.registerBuyBlood);
              break;
            }
            Get.toNamed(Routes.registerDonateBlood);
            break;
          case NavigationType.setting:
            setState(() {
              controller.activeIndex = 3;
            });
            break;
          case NavigationType.home:
            setState(() {
              controller.activeIndex = 0;
            });
            break;
          case NavigationType.notification:
            Get.toNamed(Routes.notification);
            break;
        }
      },
    );
  }
}
