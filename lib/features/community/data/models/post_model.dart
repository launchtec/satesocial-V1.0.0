import 'package:equatable/equatable.dart';

import '../../../../core/util/images.dart';

class PostModel extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String category;
  final String group;
  final String zipCode;
  final String created;
  final bool isFeatured;
  final String? rate;
  final String? employmentType;
  final String? urlDoc;

  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.category,
    required this.group,
    required this.zipCode,
    required this.created,
    required this.isFeatured,
    this.rate,
    this.employmentType,
    this.urlDoc
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'category': category,
      'group': group,
      'zipCode': zipCode,
      'created': created,
      'isFeatured': isFeatured,
      'rate': rate,
      'employmentType': employmentType,
      'urlDoc': urlDoc
    };
  }

  String imageCategory() {
    if (category == 'Romance Posting') {
      return Images.romanMarker;
    } else if (category == 'Social & Activity Posting') {
      return Images.socialMarker;
    } else {
      return Images.gigMarker;
    }
  }

  String imageCircleCategory() {
    if (category == 'Romance Posting') {
      return Images.romanceCircle;
    } else if (category == 'Social & Activity Posting') {
      return Images.socialCircle;
    } else {
      return Images.gigCircle;
    }
  }

  @override
  List<Object?> get props => [id, userId, title, content, category, group, zipCode, created, isFeatured];
}