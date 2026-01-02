import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/register_donate_blood/widgets/register_donate_blood_page_second.dart';
import 'package:blood_donation/features/register_donate_blood/widgets/register_donate_blood_question.dart';
import 'package:blood_donation/features/register_donate_blood/widgets/register_donate_blood_vital_signs_page.dart';
import 'package:blood_donation/features/register_donate_blood/widgets/register_donate_blood_reception_page.dart';
import 'package:blood_donation/features/register_donate_blood/widgets/register_donate_blood_pre_test_page.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

import '../../home/models/home_category.dart';
import '../controller/register_donate_blood_controller.dart';

class RegisterDonateBloodPage extends StatefulWidget {
  const RegisterDonateBloodPage({super.key});

  @override
  State<RegisterDonateBloodPage> createState() =>
      _RegisterDonateBloodPageState();
}

class _RegisterDonateBloodPageState extends BaseViewStateful<
    RegisterDonateBloodPage, RegisterDonateBloodController> {
  @override
  RegisterDonateBloodController dependencyController() {
    // TODO: implement dependencyController
    return RegisterDonateBloodController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Hero(
            tag: HomeCategory.registerDonateBlood.name,
            child: Text(
              AppLocale.registerDonateBlood.translate(context),
              style: context.myTheme.textThemeT1.title
                  .copyWith(color: Colors.white),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              controller.onBack();
            },
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildPageContent(),
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    switch (controller.page) {
      case 2:
        return RegisterDonateBloodPageSecond(
            state: controller, key: const ValueKey(2));
      case 3:
        return RegisterDonateBloodQuestion(
            state: controller, key: const ValueKey(3));
      case 4:
        return RegisterDonateBloodReceptionPage(
            state: controller, key: const ValueKey(4));
      case 5:
        return RegisterDonateBloodVitalSignsPage(
            state: controller, key: const ValueKey(5));
      case 6:
        return RegisterDonateBloodPreTestPage(
            state: controller, key: const ValueKey(6));
      case 7:
        return RegisterDonateBloodDoctorPage(
            state: controller, key: const ValueKey(7));
      case 8:
        return RegisterDonateBloodNursePage(
            state: controller, key: const ValueKey(8));
      default:
        // Default to form page (page 2)
        return RegisterDonateBloodPageSecond(
            state: controller, key: const ValueKey(2));
    }
  }
}
