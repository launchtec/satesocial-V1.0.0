import 'package:sate_social/core/data/data_sources/firestore_data_source.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/data/models/avatar_user.dart';
import 'package:sate_social/features/auth/data/models/user_location_fcm.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_up_use_case.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FirestoreDataSource firestoreDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.firestoreDataSource,
    required this.localDataSource,
  });

  @override
  Stream<AuthUser> get authUser {
    return remoteDataSource.user.map((authUserModel) {
      if (authUserModel != null) {
        localDataSource.write(key: 'user', value: authUserModel);
      } else {
        localDataSource.write(key: 'user', value: null);
      }

      return authUserModel == null ? AuthUser.empty : authUserModel.toEntity();
    });
  }

  @override
  Future<AppUser> getUserInfo({required String userId}) async {
    final userDocument = await firestoreDataSource.getUserInfo(userId);
    return AppUser.fromSnapshot(userDocument);
  }

  @override
  Future<void> updateUserInfo({required AppUser user}) {
    return firestoreDataSource.updateUserInfo(user);
  }

  @override
  Future<List<AppUser>> getUsers() async {
    final usersSnapshot = await firestoreDataSource.getUsers();
    return usersSnapshot.docs
        .map((doc) => AppUser.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<void> updateUserLocation({required String userId, required UserLocationFcm userLocation}) async {
    return firestoreDataSource.updateUserLocation(userId, userLocation);
  }

  @override
  Future<void> updateUserActivity({required String userId, required String lastActivity}) async {
    return firestoreDataSource.updateUserActivity(userId, lastActivity);
  }

  @override
  Future<void> updateUserBuyMatch({required String userId, required bool buyMatch}) async {
    return firestoreDataSource.updateUserBuyMatch(userId, buyMatch);
  }

  @override
  Future<void> updateUserAvatar({required String userId, required AvatarUser avatarUser}) async {
    return firestoreDataSource.updateUserAvatar(userId, avatarUser);
  }

  @override
  Future<AuthUser> signUp({
    required SignUpParams signUpParams,
  }) async {
    final authModel = await remoteDataSource.signUpWithEmailAndPassword(
      email: signUpParams.email.value,
      password: signUpParams.password.value,
      name: signUpParams.name
    );
    firestoreDataSource.addUser(AppUser(
      id: authModel.id,
      name: signUpParams.name,
      email: signUpParams.email.value,
      age: signUpParams.age,
      gender: signUpParams.gender,
      sexuality: signUpParams.sexuality,
      openToConnectTo: signUpParams.openToConnectTo,
      height: signUpParams.height,
      ethnicity: signUpParams.ethnicity,
      howDidYouKnowAboutUs: signUpParams.howDidYouKnowAboutUs,
      confirmRealPerson: signUpParams.confirmRealPerson,
      avatar: null,
    ));

    localDataSource.write(key: 'user', value: authModel);

    return authModel.toEntity();
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    localDataSource.write(key: 'user', value: authModel);

    return authModel.toEntity();
  }

  @override
  Future<bool> recoveryPass({required String email}) async {
    return await remoteDataSource.recoveryPassword(email: email);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();

    localDataSource.write(key: 'user', value: null);
  }
}
