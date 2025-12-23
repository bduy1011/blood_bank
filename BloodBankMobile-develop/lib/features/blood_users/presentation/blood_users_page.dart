import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/localization/app_locale.dart';
import '../../components/blood_search_bar.dart';
import '../../home/models/home_category.dart';
import '../controller/blood_users_controller.dart';

class BloodUsersPage extends StatefulWidget {
  const BloodUsersPage({super.key});

  @override
  State<BloodUsersPage> createState() => _BloodUsersPageState();
}

class _BloodUsersPageState
    extends BaseViewStateful<BloodUsersPage, BloodUsersController> {
  @override
  BloodUsersController dependencyController() {
    // TODO: implement dependencyController
    return BloodUsersController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          BloodSearchBar(
            hintText: "${AppLocale.search.translate(context)}...",
            onChange: (text) {
              ///
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: context.myTheme.colorScheme.appBarBackground,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded)),
      centerTitle: true,
      title: Hero(
        tag: HomeCategory.bloodDonationHistory.name,
        child: Text(
          AppLocale.bloodDonationHistory.translate(context),
          style: context.myTheme.textThemeT1.title,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              controller.onFilter(context);
            },
            icon: SvgPicture.asset(
              "assets/icons/ic_location_filter.svg",
              width: 20,
            ))
      ],
    );
  }
}
