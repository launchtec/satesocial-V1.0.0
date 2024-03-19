import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/data/data_sources/firestore_data_source.dart';
import 'package:sate_social/core/services/push_notification_service.dart';
import 'package:sate_social/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:sate_social/features/notifications/domain/repositories/notification_repository.dart';

import 'core/route/route_helper.dart';
import 'core/util/app_constants.dart';
import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/entities/auth_user.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'firebase_options.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(await builder());
}

void main() {
  bootstrap(
    () async {
      AuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      AuthRemoteDataSource authRemoteDataSource =
          AuthRemoteDataSourceFirebase();
      FirestoreDataSource firestoreDataSource = FirestoreDataSource();
      PushNotificationService pushNotificationService = PushNotificationService();

      AuthRepository authRepository = AuthRepositoryImpl(
          localDataSource: authLocalDataSource,
          remoteDataSource: authRemoteDataSource,
          firestoreDataSource: firestoreDataSource);

      NotificationRepository notificationRepository = NotificationRepositoryImpl(
          firestoreDataSource: firestoreDataSource);

      AuthUser user = await authRepository.authUser.first;

      if (user.id.isNotEmpty) {
        pushNotificationService.initialize(notificationRepository);
        FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      }

      return App(
        authRepository: authRepository,
        notificationRepository: notificationRepository,
        authUser: user,
      );
    },
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    required this.notificationRepository,
    this.authUser,
  });

  final AuthRepository authRepository;
  final NotificationRepository notificationRepository;
  final AuthUser? authUser;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: notificationRepository),
      ],
      child: GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        theme: ThemeData.light(useMaterial3: true),
        getPages: RouteHelper.routes,
        initialRoute: authUser!.id.isNotEmpty ? RouteHelper.dashboard
            : RouteHelper.welcome,
      ),
    );
  }
}
