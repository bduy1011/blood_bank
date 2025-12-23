import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';

import '../../app/app_util/app_center.dart';
import '../../app/app_util/app_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  AppCenter get appCenter => GetIt.instance<AppCenter>();
  @override
  Widget build(BuildContext context) {
    bool isNavigated = false;
    if (!isNavigated) {
      Future.delayed(const Duration(seconds: 10), () {
        if (context.mounted) {
          appCenter.state.status.value = PageStatus.idle;
          isNavigated = true;
        }
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/app_icon_oval.png",
              width: 200,
            ),
            const VSpacing(spacing: 40),
            SpinKitRipple(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven
                          ? Colors.red
                          : Colors.red.withOpacity(0.8)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
