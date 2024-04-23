import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/data/blocks/request_status.dart';

class UserUpdateState extends Equatable {
  final RequestStatus requestStatus;
  final int? age;
  final String? height;
  final String? ethnicity;
  final String? gender;
  final String? sexuality;
  final List<String>? openToConnectTo;
  final String? relationship;
  final bool? activeRelationship;
  final String? userLinkInstagram;
  final bool? activeInstagram;

  const UserUpdateState({
    this.requestStatus = RequestStatus.initial,
    this.age,
    this.height,
    this.ethnicity,
    this.gender,
    this.sexuality,
    this.openToConnectTo,
    this.relationship,
    this.activeRelationship,
    this.userLinkInstagram,
    this.activeInstagram
  });

  UserUpdateState copyWith({
    RequestStatus? requestStatus,
    int? age,
    String? height,
    String? ethnicity,
    String? gender,
    String? sexuality,
    List<String>? openToConnectTo,
    String? relationship,
    bool? activeRelationship,
    String? userLinkInstagram,
    bool? activeInstagram
  }) {
    return UserUpdateState(
      requestStatus: requestStatus ?? this.requestStatus,
      age: age ?? this.age,
      height: height ?? this.height,
      ethnicity: ethnicity ?? this.ethnicity,
      gender: gender ?? this.gender,
      sexuality: sexuality ?? this.sexuality,
      openToConnectTo: openToConnectTo ?? this.openToConnectTo,
      relationship: relationship ?? this.relationship,
      activeRelationship: activeRelationship ?? this.activeRelationship,
      userLinkInstagram: userLinkInstagram ?? this.userLinkInstagram,
      activeInstagram: activeInstagram ?? this.activeInstagram,
    );
  }

  @override
  List<Object?> get props => [
    requestStatus,
    age,
    height,
    ethnicity,
    gender,
    sexuality,
    openToConnectTo,
    relationship,
    activeRelationship,
    userLinkInstagram,
    activeInstagram
  ];
}