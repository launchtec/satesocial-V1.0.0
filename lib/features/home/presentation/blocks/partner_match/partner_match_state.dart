import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class PartnerMatchState extends Equatable {
  final List<String> religions;
  final List<String> ethnicities;
  final List<String> educations;
  final String? age;
  final List<String> bodyTypes;
  final String? diet;
  final String? politics;
  final RequestStatus requestStatus;

  const PartnerMatchState({
    this.religions = const [],
    this.ethnicities = const [],
    this.educations = const [],
    this.age,
    this.bodyTypes = const [],
    this.diet,
    this.politics,
    this.requestStatus = RequestStatus.initial
  });

  PartnerMatchState copyWith({
    List<String>? religions,
    List<String>? ethnicities,
    List<String>? educations,
    String? age,
    List<String>? bodyTypes,
    String? diet,
    String? politics,
    RequestStatus? requestStatus
  }){
    return PartnerMatchState(
      religions: religions ?? this.religions,
      ethnicities: ethnicities ?? this.ethnicities,
      educations: educations ?? this.educations,
      age: age ?? this.age,
      bodyTypes: bodyTypes ?? this.bodyTypes,
      diet: diet ?? this.diet,
      politics: politics ?? this.politics,
      requestStatus: requestStatus ?? this.requestStatus
    );
  }

  @override
  List<Object?> get props => [
    religions,
    ethnicities,
    educations,
    age,
    bodyTypes,
    diet,
    politics,
    requestStatus
  ];

}