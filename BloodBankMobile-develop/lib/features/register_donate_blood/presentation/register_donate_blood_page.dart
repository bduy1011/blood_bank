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
    RegisterDonateBloodPage, RegisterDonateBloodController> with WidgetsBindingObserver {
  @override
  RegisterDonateBloodController dependencyController() {
    // TODO: implement dependencyController
    return RegisterDonateBloodController();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Khi app trở lại foreground, reload dữ liệu
    if (state == AppLifecycleState.resumed) {
      controller.initProfile();
    }
  }

  bool _hasInitialized = false;
  DateTime? _lastReloadTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload dữ liệu khi dependencies thay đổi (khi quay lại từ màn hình khác)
    if (_hasInitialized) {
      // Chỉ reload nếu đã được khởi tạo trước đó (tức là đang quay lại, không phải lần đầu mở)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _reloadProfileData();
      });
    } else {
      _hasInitialized = true;
    }
  }

  void _reloadProfileData() {
    // Debounce: chỉ reload nếu đã qua ít nhất 300ms từ lần reload trước
    final now = DateTime.now();
    if (_lastReloadTime == null || 
        now.difference(_lastReloadTime!) > const Duration(milliseconds: 300)) {
      _lastReloadTime = now;
      controller.initProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reload dữ liệu khi build (khi quay lại từ màn hình khác)
    // Sử dụng post-frame callback và debounce để tránh gọi quá nhiều lần
    if (_hasInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _reloadProfileData();
        }
      });
    }
    
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
