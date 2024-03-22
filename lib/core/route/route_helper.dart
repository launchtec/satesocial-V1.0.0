import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sate_social/features/auth/presentation/screens/recovery_pass_screen.dart';
import 'package:sate_social/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:sate_social/features/auth/presentation/screens/welcome_screen.dart';
import 'package:sate_social/features/community/presentation/screens/posting_screen.dart';
import 'package:sate_social/features/dashboard/dashboard_screen.dart';

import '../../features/auth/presentation/screens/sign_up_screen.dart';

class RouteHelper {
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String recoveryPass = '/recovery-pass';
  static const String dashboard = '/dashboard';
  static const String dashboardToNotification = '/dashboard-to-notification';
  static const String createPost = '/create-post';

  static String getWelcomeRoute() => welcome;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getRecoveryPassRoute() => recoveryPass;
  static String getDashboardRoute() => dashboard;
  static String getDashboardToNotificationRoute() => dashboardToNotification;
  static String getCreatePostRoute() => createPost;

  static List<GetPage> routes = [
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: recoveryPass, page: () => const RecoveryPassScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: dashboardToNotification, page: () => const DashboardScreen(openNotification: true)),
    GetPage(name: createPost, page: () => const PostingScreen()),
  ];
}