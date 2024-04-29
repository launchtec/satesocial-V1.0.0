import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';

class CreatePostState extends Equatable {
  final String? title;
  final String? content;
  final String? category;
  final String? group;
  final String? zipCode;
  final String? rate;
  final String? employmentType;
  final File? uploadDoc;
  final RequestStatus requestStatus;

  const CreatePostState({
    this.title,
    this.content,
    this.category,
    this.group,
    this.zipCode,
    this.rate,
    this.employmentType,
    this.uploadDoc,
    this.requestStatus = RequestStatus.initial,
  });

  CreatePostState copyWith(
      {String? title,
      String? content,
      String? category,
      String? group,
      String? zipCode,
      String? rate,
      String? employmentType,
      File? uploadDoc,
      RequestStatus? requestStatus}) {
    return CreatePostState(
        title: title ?? this.title,
        content: content ?? this.content,
        category: category ?? this.category,
        group: group ?? this.group,
        zipCode: zipCode ?? this.zipCode,
        rate: rate ?? this.rate,
        employmentType: employmentType ?? this.employmentType,
        uploadDoc: uploadDoc ?? this.uploadDoc,
        requestStatus: requestStatus ?? this.requestStatus);
  }

  @override
  List<Object?> get props => [
        title,
        content,
        category,
        group,
        zipCode,
        rate,
        employmentType,
        uploadDoc,
        requestStatus
      ];
}
