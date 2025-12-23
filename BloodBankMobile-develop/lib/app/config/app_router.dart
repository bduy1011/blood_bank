import 'package:blood_donation/app/app_page/app_page.dart';
import 'package:blood_donation/features/account/presentation/change_password.dart';
import 'package:blood_donation/features/account/presentation/login_page.dart';
import 'package:blood_donation/features/blood_locations/presentation/blood_locations_donate_page.dart';
import 'package:blood_donation/features/blood_users/presentation/blood_users_page.dart';
import 'package:blood_donation/features/donation_schedule/presentation/history_page.dart';
import 'package:blood_donation/features/feedback/add_feedback_page.dart';
import 'package:blood_donation/features/feedback/feedback_page.dart';
import 'package:blood_donation/features/history_register_buy_blood/presentation/history_register_buy_blood_page.dart';
import 'package:blood_donation/features/home/presentation/home_page.dart';
import 'package:blood_donation/features/management/presentation/management_page.dart';
import 'package:blood_donation/features/management_buy_blood/presentation/approve_buy_blood_page.dart';
import 'package:blood_donation/features/news/presentation/news_page.dart';
import 'package:blood_donation/features/notification/presentation/notification_page.dart';
import 'package:blood_donation/features/profile/presentation/profile_page.dart';
import 'package:blood_donation/features/question_answer/presentation/question_answer_page.dart';
import 'package:blood_donation/features/register_buy_blood/presentation/register_buy_blood_page.dart';
import 'package:blood_donation/features/register_donate_blood/presentation/register_donate_blood_page.dart';
import 'package:blood_donation/features/settings/presentation/settings_page.dart';
import 'package:blood_donation/features/splash/splash_page.dart';
import 'package:get/get.dart';

import '../../features/blood_locations/presentation/blood_locations_history_page.dart';
import 'routes.dart';

class AppRouter {
  static List<GetPage> get pages => [
        GetPage(
            name: Routes.appPage,
            page: () => const AppPage(),
            fullscreenDialog: true,
            children: [
              GetPage(
                name: Routes.home,
                page: () => const HomePage(),
              ),
              GetPage(
                name: Routes.settings,
                page: () => const SettingsPage(),
              ),
            ]),
        GetPage(
          name: Routes.home,
          page: () => const HomePage(),
        ),
        GetPage(
          name: Routes.settings,
          page: () => const SettingsPage(),
        ),
        GetPage(
          name: Routes.bloodHistoryLocations,
          page: () => const BloodLocationsHistoryPage(),
        ),
        GetPage(
          name: Routes.historyDonateBlood,
          page: () => const BloodLocationsDonatePage(),
        ),
        GetPage(
          name: Routes.bloodUsers,
          page: () => const BloodUsersPage(),
        ),
        GetPage(
          name: Routes.historyRegisterBuyBlood,
          page: () => const HistoryRegisterBuyBloodPage(),
        ),
        GetPage(
          name: Routes.management,
          page: () => const ManagementPage(),
        ),
        GetPage(
          name: Routes.login,
          page: () => const LoginPage(),
        ),
        GetPage(
          name: Routes.registerBuyBlood,
          page: () => const RegisterBuyBloodPage(),
        ),
        GetPage(
          name: Routes.approveBuyBlood,
          page: () => const ApproveBuyBloodPage(),
        ),
        GetPage(
          name: Routes.history,
          page: () => const HistoryPage(),
        ),
        GetPage(page: () => const ProfilePage(), name: Routes.profile),
        GetPage(page: () => const NewsPage(), name: Routes.news),
        GetPage(page: () => const SplashPage(), name: Routes.splash),
        GetPage(
            page: () => const QuestionAnswerPage(),
            name: Routes.questionAnswer),
        GetPage(
            page: () => const RegisterDonateBloodPage(),
            name: Routes.registerDonateBlood),
        GetPage(page: () => const FeedbackSupportPage(), name: Routes.feedback),
        GetPage(
            page: () => const AddFeedbackSupportPage(),
            name: Routes.addFeedback),
        GetPage(
          page: () => const NotificationPage(),
          name: Routes.notification,
        ),
        GetPage(
          page: () => const ChangePassword(),
          name: Routes.changePassword,
        ),
      ];
}
