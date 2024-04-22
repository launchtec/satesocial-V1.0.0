import 'dart:convert';

import 'package:get/get.dart';
import 'package:sate_social/features/auth/presentation/screens/recovery_pass_screen.dart';
import 'package:sate_social/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:sate_social/features/auth/presentation/screens/welcome_screen.dart';
import 'package:sate_social/features/community/presentation/screens/manage_listings_screen.dart';
import 'package:sate_social/features/community/presentation/screens/map_posts_screen.dart';
import 'package:sate_social/features/community/presentation/screens/posting_screen.dart';
import 'package:sate_social/features/dashboard/dashboard_screen.dart';
import 'package:sate_social/features/messages/presentation/screens/chat_screen.dart';
import 'package:sate_social/features/messages/presentation/screens/conversations_screen.dart';

import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/messages/data/models/chat.dart';

class RouteHelper {
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String recoveryPass = '/recovery-pass';
  static const String dashboard = '/dashboard';
  static const String dashboardToNotification = '/dashboard-to-notification';
  static const String createPost = '/create-post';
  static const String mapPost = '/map-post';
  static const String manageListings = '/manage-listings';
  static const String communityChats = '/community-chats';
  static const String connectChats = '/connect-chats';
  static const String openChat = '/open-chat';

  static String getWelcomeRoute() => welcome;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getRecoveryPassRoute() => recoveryPass;
  static String getDashboardRoute() => dashboard;
  static String getDashboardToNotificationRoute() => dashboardToNotification;
  static String getCreatePostRoute() => createPost;
  static String getMapPostRoute({required String category}) => '$mapPost?category=$category';
  static String getManageListingsRoute() => manageListings;
  static String getCommunityChatsRoute() => communityChats;
  static String getConnectChatsRoute() => connectChats;
  static String getOpenChatRoute(Chat chat) {
    String chatJson = jsonEncode(chat.toMapJson());
    return '$openChat?chat=$chatJson';
  }

  static List<GetPage> routes = [
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: recoveryPass, page: () => const RecoveryPassScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: dashboardToNotification, page: () => const DashboardScreen(openNotification: true)),
    GetPage(name: createPost, page: () => const PostingScreen()),
    GetPage(name: mapPost, page: () => MapPostsScreen(category: Get.parameters['category'] ?? '')),
    GetPage(name: manageListings, page: () => const ManageListingsScreen()),
    GetPage(name: communityChats, page: () => const ConversationsScreen(isCommunity: true)),
    GetPage(name: connectChats, page: () => const ConversationsScreen(isCommunity: false)),
    GetPage(name: openChat, page: () {
      Chat chat = Chat.fromMap(jsonDecode(Get.parameters['chat']!));
      return ChatScreen(chat: chat);
    }),
  ];
}