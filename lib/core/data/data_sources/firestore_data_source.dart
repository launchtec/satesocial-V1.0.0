import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sate_social/features/auth/data/models/avatar_user.dart';
import 'package:sate_social/features/auth/data/models/user_location_fcm.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/home/data/models/partner_match_model.dart';
import 'package:sate_social/features/home/data/models/self_match_model.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../../../features/auth/data/models/app_user.dart';
import '../../../features/messages/data/models/chat.dart';
import '../../../features/messages/data/models/message.dart';
import '../models/match.dart';
import '../models/swipe.dart';

class FirestoreDataSource {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  void addUser(AppUser user) {
    instance.collection('users').doc(user.id).set(user.toMap());
  }

  Future<DocumentSnapshot> getUserInfo(String userId) {
    return instance.collection('users').doc(userId).get();
  }

  Future<QuerySnapshot> getUsers() {
    return instance.collection('users').get();
  }

  Future<void> updateUserLocation(String userId, UserLocationFcm userLocation) {
    return instance.collection('users').doc(userId).update(userLocation.toMap());
  }

  Future<void> updateUserActivity(String userId, String lastActivity) {
    return instance.collection('users').doc(userId).update({"lastActivity" : lastActivity});
  }

  Future<void> updateUserBuyMatch(String userId, bool buyMatch) {
    return instance.collection('users').doc(userId).update({"buyMatch" : buyMatch});
  }

  Future<void> updateUserAvatar(String userId, AvatarUser avatarUser) {
    return instance.collection('users').doc(userId).update(avatarUser.toMap());
  }

  Future<void> updateUserInfo(AppUser user) {
    return instance.collection('users').doc(user.id).update(user.toMap());
  }

  Future<void> addOrUpdateNotification(NotificationModel notification) {
    return instance
        .collection('notifications')
        .doc(notification.id)
        .set(notification.toMap());
  }

  Future<QuerySnapshot> getNotifications(String userId) {
    return instance.collection('notifications').where(Filter("recipientUserId", isEqualTo: userId)).get();
  }

  Stream<QuerySnapshot> getStreamNotifications(String userId) {
    return instance.collection('notifications').where(Filter("recipientUserId", isEqualTo: userId)).snapshots();
  }

  Future<void> addOrUpdatePost(PostModel postModel) {
    return instance
        .collection('posts')
        .doc(postModel.id)
        .set(postModel.toMap());
  }

  Future<QuerySnapshot> getPosts() {
    return instance.collection('posts').get();
  }

  Future<DocumentSnapshot> getPost(String postId) {
    return instance.collection('posts').doc(postId).get();
  }

  Future<QuerySnapshot> getPostsCategory(String category) {
    return instance.collection('posts').where("category", isEqualTo: category).get();
  }

  Stream<QuerySnapshot> getStreamPosts() {
    return instance.collection('posts').snapshots();
  }

  Stream<QuerySnapshot> getExistingUserPosts(String userId) {
    return instance.collection('posts').where("userId", isEqualTo: userId).snapshots();
  }

  Future<void> deletePost(String postId) {
    return instance.collection('posts').doc(postId).delete();
  }

  Future<void> addSelfMatchForm(String userId, SelfMatchModel selfMatchModel) {
    return instance
        .collection('users')
        .doc(userId)
        .collection('self_match_form')
        .doc(selfMatchModel.id)
        .set(selfMatchModel.toMap());
  }

  Future<void> addPartnerMatchForm(String userId, PartnerMatchModel partnerMatchModel) {
    return instance
        .collection('users')
        .doc(userId)
        .collection('partner_match_form')
        .doc(partnerMatchModel.id)
        .set(partnerMatchModel.toMap());
  }

  Future<void> addChat(Chat chat) {
    return instance.collection('chats').doc(chat.id).set(chat.toMap());
  }

  Future<DocumentSnapshot> getChat(String chatId) {
    return instance.collection('chats').doc(chatId).get();
  }

  // First owner post responses
  Future<QuerySnapshot> getChats(String userId) {
    return instance.collection('chats').where(Filter.or(
        Filter("senderId", isEqualTo: userId),
        Filter("receiverId", isEqualTo: userId),
    )).get();
  }

  Stream<QuerySnapshot> getStreamChats(String userId) {
    return instance.collection('chats').where(Filter.or(
        Filter("senderId", isEqualTo: userId),
        Filter("receiverId", isEqualTo: userId)
    )).snapshots();
  }

  Future<void> addMessage(String chatId, Message message) {
    return instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<QuerySnapshot> getStreamMessages(String chatId) {
    return instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('created', descending: false)
        .snapshots();
  }

  // Future functions
  void addMatch(String userId, Match match) {
    instance
        .collection('users')
        .doc(userId)
        .collection('matches')
        .doc(match.id)
        .set(match.toMap());
  }

  void addSwipedUser(String userId, Swipe swipe) {
    instance
        .collection('users')
        .doc(userId)
        .collection('swipes')
        .doc(swipe.id)
        .set(swipe.toMap());
  }

  void updateUser(AppUser user) async {
    instance.collection('users').doc(user.id).update(user.toMap());
  }

  void updateChat(Chat chat) {
    instance.collection('chats').doc(chat.id).update(chat.toMap());
  }

  void updateMessage(String chatId, String messageId, Message message) {
    instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update(message.toMap());
  }

  Future<DocumentSnapshot> getUser(String userId) {
    return instance.collection('users').doc(userId).get();
  }

  Future<DocumentSnapshot> getSwipe(String userId, String swipeId) {
    return instance
        .collection('users')
        .doc(userId)
        .collection('swipes')
        .doc(swipeId)
        .get();
  }

  Future<QuerySnapshot> getMatches(String userId) {
    return instance.collection('users').doc(userId).collection('matches').get();
  }

  Future<QuerySnapshot> getPersonsToMatchWith(
      int limit, List<String> ignoreIds) {
    return instance
        .collection('users')
        .where('id', whereNotIn: ignoreIds)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot> getSwipes(String userId) {
    return instance.collection('users').doc(userId).collection('swipes').get();
  }

  Stream<DocumentSnapshot> observeUser(String userId) {
    return instance.collection('users').doc(userId).snapshots();
  }

  Stream<DocumentSnapshot> observeChat(String chatId) {
    return instance.collection('chats').doc(chatId).snapshots();
  }
}