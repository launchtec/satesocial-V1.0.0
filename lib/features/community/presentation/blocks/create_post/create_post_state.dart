import 'package:equatable/equatable.dart';
import 'package:sate_social/core/data/blocks/form_status.dart';

class CreatePostState extends Equatable {
  final String? title;
  final String? content;
  final String? category;
  final String? group;
  final String? zipCode;
  final FormStatus formStatus;

  const CreatePostState({
    this.title,
    this.content,
    this.category,
    this.group,
    this.zipCode,
    this.formStatus = FormStatus.initial,
  });

  CreatePostState copyWith({String? title, String? content, String? category, String? group, String? zipCode, FormStatus? formStatus}) {
    return CreatePostState(
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      group: group ?? this.group,
      zipCode: zipCode ?? this.zipCode,
      formStatus: formStatus ?? this.formStatus
    );
  }


  @override
  List<Object?> get props => [
    title, content, category, group, zipCode, formStatus
  ];
}