import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sate_social/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:sate_social/features/auth/presentation/screens/welcome_screen.dart';

import '../../features/auth/presentation/screens/sign_up_screen.dart';

class RouteHelper {
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  static String getWelcomeRoute() => welcome;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;

  static List<GetPage> routes = [
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
  ];

}