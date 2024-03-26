import 'package:equatable/equatable.dart';

import '../../../domain/value_objects/email.dart';
import '../email_status.dart';
import '../../../../../core/data/blocks/form_status.dart';

class RecoveryPassState extends Equatable {
  final Email? email;
  final EmailStatus emailStatus;
  final FormStatus formStatus;

  const RecoveryPassState({
    this.email,
    this.emailStatus = EmailStatus.unknown,
    this.formStatus = FormStatus.initial
  });

  RecoveryPassState copyWith({
    Email? email,
    EmailStatus? emailStatus,
    FormStatus? formStatus,
  }) {
    return RecoveryPassState(
      email: email ?? this.email,
      emailStatus: emailStatus ?? this.emailStatus,
      formStatus: formStatus ?? this.formStatus
    );
  }

  @override
  List<Object?> get props => [
    email,
    emailStatus,
    formStatus
  ];
}