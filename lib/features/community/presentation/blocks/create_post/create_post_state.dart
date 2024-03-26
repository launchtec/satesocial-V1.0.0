import 'package:equatable/equatable.dart';
import 'package:sate_social/core/data/blocks/form_status.dart';

class CreatePostState extends Equatable {
  final FormStatus formStatus;

  const CreatePostState({
    this.formStatus = FormStatus.initial,
  });

  @override
  List<Object?> get props => [formStatus];
}