import 'package:animated_background/animated_background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/app/config/routes.dart';
import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/home/models/home_menu_type.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../models/news_response.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseViewStateful<HomePage, HomeController> {
  _HomePageState() : super(isReusable: true);
  @override
  HomeController dependencyController() {
    // TODO: implement dependencyController
    return HomeController();
  }

  @override
  Widget build(BuildContext context) {
    //  return Obx(() {

    //   },);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              color: AppColor.mainColor,
              height: Get.height / 2,
              width: double.infinity,
            ),
          ),
          Positioned(
            child: Column(
              children: [
                HomeHeaderWidget(
                  controller: controller,
                  parentContext: context,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      header: const WaterDropMaterialHeader(
                          backgroundColor: AppColor.mainColor),
                      controller:
                          controller.refreshController ?? RefreshController(),
                      onRefresh: () {
                        controller.onRefresh();
                      },
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const VSpacing(
                              spacing: 20,
                            ),
                            buildSlide(),
                            const VSpacing(
                              spacing: 20,
                            ),
                            Text(
                              AppLocale.functions.translate(context).toUpperCase(),
                              style: context.myTheme.textThemeT1.title,
                            ),
                            buildMenus(),
                            buildNewsTitle(context),
                            buildNews(),
                            const VSpacing(
                              spacing: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ClipRRect buildSlide() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpacing(),
            buildNote(),
            const VSpacing(),
            Obx(
              () => FlutterCarousel.builder(
                  itemCount: controller.slides.value.length,
                  itemBuilder: (context, index, realIndex) {
                    var slide = controller.slides.length > index
                        ? controller.slides[index]
                        : null;
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          if (slide != null) {
                            controller.onTapSlideItem(slide);
                          }
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.transparent,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(),
                          imageUrl: slide?.url ?? "",
                        ),
                      ),
                    );
                  },
                  options: FlutterCarouselOptions(
                      disableCenter: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      showIndicator: false,
                      floatingIndicator: false)),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildNote() {
    if (controller.appCenter.authentication?.cmnd == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: '${AppLocale.notUpdatePersonalInfo.translate(context)}\n',
            style: context.myTheme.textThemeT1.body
                .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                text: '>> ${AppLocale.updateNow.translate(context)} <<',
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    ///
                    await Get.toNamed(Routes.profile);
                    setState(() {});
                  },
                style: context.myTheme.textThemeT1.body.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColor.mainColor),
              ),
            ],
          ),
        ),
      );
    }
    if (controller.appCenter.authentication?.ngayHienMauGanNhat != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    AppLocale.daysSinceLastDonation.translate(context).replaceAll('{days}', '${DateTime.now().difference(controller.appCenter.authentication!.ngayHienMauGanNhat!).inDays}'),
                style: context.myTheme.textThemeT1.body
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text:
                    AppLocale.lastDonation.translate(context).replaceAll('{date}', controller.appCenter.authentication?.ngayHienMauGanNhat?.dateTimeString ?? ''),
                style: context.myTheme.textThemeT1.body.copyWith(fontSize: 16),
              )
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: controller.appCenter.authentication?.soLanHienMau != null &&
                      controller.appCenter.authentication!.soLanHienMau! > 0
                  ? AppLocale.welcomeBack.translate(context)
                  : AppLocale.notDonatedYet.translate(context),
              style: context.myTheme.textThemeT1.body
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildNews() {
    double height = 200;
    return SizedBox(
      height: height,
      width: Get.width,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return buildNewsItem(context, controller.news[index], height);
          },
          separatorBuilder: (context, index) => const HSpacing(
            spacing: 20,
          ),
          itemCount: controller.news.value.length,
        ),
      ),
    );
  }

  InkWell buildNewsItem(
      BuildContext context, NewsResponse item, double height) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.news, arguments: {"news": item}),
      child: Container(
        height: height,
        width: Get.width * 0.7,
        margin: const EdgeInsets.all(2),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
              blurRadius: 6,
              color: Colors.grey.withOpacity(0.25),
              blurStyle: BlurStyle.outer)
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  width: Get.width * 0.7,
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: Get.width * 0.7,
                    errorWidget: (context, url, error) => const VSpacing(),
                    imageUrl: item.thumbnailLink ?? "",
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.tieuDe ?? '',
                    style: context.myTheme.textThemeT1.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.createdOn?.dateTimeHourString ?? "",
                    style: context.myTheme.textThemeT1.body
                        .copyWith(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildNewsTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              AppLocale.news.translate(context).toUpperCase(),
              style: context.myTheme.textThemeT1.title,
            ),
          ),
          // TextButton(
          //     onPressed: () {},
          //     child: Text(
          //       "Xem thêm...",
          //       style: context.myTheme.textThemeT1.body
          //           .copyWith(
          //               fontStyle: FontStyle.italic,
          //               color: Colors.black.withOpacity(0.7)),
          //     ))
        ],
      ),
    );
  }

  Widget buildMenus() {
    AutoSizeGroup autoSizeGroup = AutoSizeGroup();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: Colors.transparent,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: controller.categories
              .map((item) => Hero(
                    tag: item.name,
                    child: InkWell(
                      onTap: () {
                        controller.onTapMenu(item);
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        width: (Get.width - 60) / 3,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                item.icon,
                                height: 32,
                                width: 35,
                                fit: BoxFit.contain,
                                // colorFilter: ColorFilter.mode(
                                //     context.myTheme.colorScheme.primary, BlendMode.srcIn),
                              ),
                            ),
                            const VSpacing(),
                            AutoSizeText(
                              group: autoSizeGroup,
                              item.title(context),
                              style: context.myTheme.textThemeT1.body,
                              textAlign: TextAlign.center,
                              maxFontSize: 14,
                              minFontSize: 12,
                              maxLines: 3,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );

    // return GridView.builder(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: controller.categories.length,
    //   padding: const EdgeInsets.symmetric(vertical: 10),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     childAspectRatio: 3 / 3.1,
    //     crossAxisCount: 4,
    //     mainAxisSpacing: 5,
    //     crossAxisSpacing: 5,
    //   ),
    //   itemBuilder: (context, index) {
    //     final item = controller.categories[index];
    //     return Hero(
    //       tag: item.name,
    //       child: InkWell(
    //         onTap: () {
    //           controller.onTapMenu(item);
    //         },
    //         borderRadius: BorderRadius.circular(15),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Align(
    //               alignment: Alignment.center,
    //               child: Image.asset(
    //                 item.icon,
    //                 height: 28,
    //                 width: 28,
    //                 fit: BoxFit.contain,
    //                 // colorFilter: ColorFilter.mode(
    //                 //     context.myTheme.colorScheme.primary, BlendMode.srcIn),
    //               ),
    //             ),
    //             const VSpacing(),
    //             Expanded(
    //               child: AutoSizeText(
    //                 // group: autoSizeGroup,
    //                 item.title.translate(context),
    //                 style: context.myTheme.textThemeT1.body,
    //                 textAlign: TextAlign.center,
    //                 maxFontSize: 14,
    //                 minFontSize: 12,
    //                 maxLines: 3,
    //                 overflow: TextOverflow.visible,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget(
      {super.key, required this.controller, required this.parentContext});
  final HomeController controller;
  final BuildContext parentContext;
  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget>
    with TickerProviderStateMixin {
  final key = GlobalKey();
  double headerHeight = -1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = key.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        headerHeight = box.size.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (headerHeight != -1) ...{
          SizedBox(
            height: headerHeight,
            child: AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(options: particles),
              child: const SizedBox.shrink(),
            ),
          )
        },
        Column(
          key: key,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppBar(widget.parentContext),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VSpacing(
                    spacing: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 1),
                              color: context.myTheme.colorScheme.primary,
                            ),
                            alignment: Alignment.center,
                            width: 65,
                            height: 65,
                            child: Text(
                              widget.controller.appCenter.authentication
                                      ?.dmNguoiHienMau?.tenNhomMau ??
                                  "--",
                              style: context.myTheme.textThemeT1.title.copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const VSpacing(),
                          Text(AppLocale.bloodType.translate(context),
                              style: context.myTheme.textThemeT1.title.copyWith(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              )),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                color: context.myTheme.colorScheme.primary),
                            alignment: Alignment.center,
                            width: 65,
                            height: 65,
                            child: Text(
                              (widget.controller.appCenter.authentication
                                              ?.dmNguoiHienMau?.soLanHienMau ??
                                          0) >
                                      0
                                  ? "${(widget.controller.appCenter.authentication?.dmNguoiHienMau?.soLanHienMau ?? 0)}"
                                  : "--",
                              style: context.myTheme.textThemeT1.title.copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const VSpacing(),
                          Text(AppLocale.numberOfBloodDonations.translate(context),
                              style: context.myTheme.textThemeT1.title.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic))
                        ],
                      )
                    ],
                  ),
                  const VSpacing(
                    spacing: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.red,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 50,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 15.0,
    spawnMinSpeed: 10,
    spawnMinRadius: 7.0,
  );

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leadingWidth: 45,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
            )),
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          "assets/icons/ic_home_profile.svg",
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          height: 30,
          width: 30,
          fit: BoxFit.scaleDown,
        ),
      ),
      title: AutoSizeText(
        getHoTenNHM(),
        style: context.myTheme.textThemeT1.title.copyWith(color: Colors.white),
        maxFontSize: 20,
        minFontSize: 18,
      ),
      actions: [
        // IconButton(
        //     onPressed: () {},
        //     icon: SvgPicture.asset(
        //       "assets/icons/ic_home_notification.svg",
        //       width: 20,
        //       colorFilter:
        //           const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        //     )),
        Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                SmartDialog.showAttach(
                  targetContext: context,
                  builder: (context) {
                    return buildHomeMenu(context);
                  },
                );
              },
              icon: SvgPicture.asset(
                "assets/icons/ic_home_menu.svg",
                width: 20,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ));
        })
      ],
    );
  }

  String getHoTenNHM() {
    var dmNhm = widget.controller.appCenter.authentication?.dmNguoiHienMau;
    if (dmNhm != null) {
      return "${dmNhm.hoVaTen} (${dmNhm.namSinh})";
    }

    return widget.controller.appCenter.authentication?.name?.toUpperCase() ??
        "";
  }

  Widget buildHomeMenu(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              SmartDialog.dismiss().then((_) {
                Get.toNamed(Routes.profile);
              });
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  HomeMenuType.profile.icon,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                      context.myTheme.colorScheme.primary, BlendMode.srcIn),
                ),
                const HSpacing(
                  spacing: 20,
                ),
                Text(
                  HomeMenuType.profile.title(context),
                  style: context.myTheme.textThemeT1.body,
                )
              ],
            ),
          ),
          const VSpacing(
            spacing: 20,
          ),
          Divider(
            height: 1,
            color: context.myTheme.colorScheme.primary,
          ),
          ...[
            // HomeMenuType.setting,
            // HomeMenuType.about,
            HomeMenuType.logout
          ].map((e) => GestureDetector(
                onTap: () {
                  SmartDialog.dismiss().then((_) {
                    if (e == HomeMenuType.logout) {
                      widget.controller.logout();
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        e.icon,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            context.myTheme.colorScheme.primary,
                            BlendMode.srcIn),
                      ),
                      const HSpacing(
                        spacing: 20,
                      ),
                      Text(
                        e.title(context),
                        style: context.myTheme.textThemeT1.body,
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
