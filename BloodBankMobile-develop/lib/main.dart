import 'package:blood_donation/app/config/app_config.dart';
import 'package:blood_donation/app/config/app_router.dart';
import 'package:blood_donation/core/backend/backend_provider.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/di/injector.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';

import 'app/app_util/app_center.dart';
import 'app/config/routes.dart';
import 'core/storage/local_storage.dart';
import 'utils/widget/loading_widget.dart';

void main() async {
  // usePathUrlStrategy();
  // runZonedGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(AppConfig.prod());
  // Init
  await Firebase.initializeApp();

  ///
  await LocalStorage().init();

  ///
  configLoading();
  BackendProvider().create(url: getIt<AppConfig>().backendUrl);

  runApp(const MainPage());
  // }, (error, stackTrace) {
  //   log("runZonedGuarded() $error", error: error, stackTrace: stackTrace);
  // });
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AppLocale {
  final appCenter = GetIt.instance<AppCenter>();

  @override
  void initState() {
    init(mapLocales: [
      AppLanguage.vi.defaultLocale,
      // AppLanguage.en.defaultLocale
    ], initLanguage: AppLanguage.vi);
    // var data = AlgorisUtils.decrypt(
    //     "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");
    // var data = AlgorisUtils.decrypt(
    //     "c3JZDx97K/dZbape9DKPknCIBg4F4LsOi/S5nRa2aZFjb6peXDG4E9FbDwRHThozQ/RRuRDpUGEMXfw1kxUBrwURU4ixKaWrZ56/O+RWiBfFogOqnowGX5rVgfbkxk4y0owFHVh1UeWg0WsijMT31GqmFWYkMlRh15rUwyfJVB6zGOLeEfFMYzSIj7EnPsYZSvStnoNg4nlNEU+UBXC+58qWKPxMpHm9h+HvjzILYaC3eISTlOQQd9LNAXeFJKZcbAbxi4Kzv2ZETuO/ZoyXXddcfs8yh0p9NXMDKFfauc0NdxhV7c+syfiyKhHLg1PbsirWwIzwzw4eaAsjHHwmng90BYASAmG9MTHH3yoLr5EuWBYerIvMbTU8G5pDczc9hubUEIrmBNlHSzmjfum47w==");
    // log(data);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child0) {
        return ToastificationWrapper(
          child: GetMaterialApp(
            title: 'Blood Bank Donation',
            debugShowCheckedModeBanner: false,
            builder: FlutterSmartDialog.init(
              builder: EasyLoading.init(
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: ResponsiveBreakpoints.builder(breakpoints: [
                    const Breakpoint(start: 0, end: 450, name: MOBILE),
                    const Breakpoint(start: 451, end: 800, name: TABLET),
                    const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  ], child: child!),
                ),
              ),
            ),
            defaultTransition: Transition.fadeIn,
            // routerDelegate: appCenter.appRouter.delegate(navigatorObservers: () {
            //   return [FlutterSmartDialog.observer];
            // }),
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,
            // routeInformationParser: appCenter.appRouter.defaultRouteParser(),
            theme: appCenter.state.appTheme.themeData,
            getPages: AppRouter.pages,
            initialRoute: Routes.appPage,
            onReady: () {
              AppUtils.instance.onReady(context);
            },
          ),
        );
      },
    );
  }

  @override
  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }
}
