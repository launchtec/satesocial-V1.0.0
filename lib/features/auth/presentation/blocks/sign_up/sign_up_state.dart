part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final String? name;
  final Email? email;
  final Password? password;
  final String? gender;
  final int? age;
  final String? height;
  final String? ethnicity;
  final String? sexuality;
  final List<String> openToConnectTo;
  final String? howDidYouKnowAboutUs;
  final bool? confirmRealPerson;
  final EmailStatus emailStatus;
  final PasswordStatus passwordStatus;
  final FormStatus formStatus;

  const SignUpState({
    this.name,
    this.email,
    this.password,
    this.gender,
    this.age,
    this.height,
    this.ethnicity,
    this.sexuality,
    this.openToConnectTo = const [],
    this.howDidYouKnowAboutUs,
    this.confirmRealPerson,
    this.emailStatus = EmailStatus.unknown,
    this.passwordStatus = PasswordStatus.unknown,
    this.formStatus = FormStatus.initial,
  });

  SignUpState copyWith({
    String? name,
    Email? email,
    Password? password,
    String? gender,
    int? age,
    String? height,
    String? ethnicity,
    String? sexuality,
    List<String>? openToConnectTo,
    String? howDidYouKnowAboutUs,
    bool? confirmRealPerson,
    EmailStatus? emailStatus,
    PasswordStatus? passwordStatus,
    FormStatus? formStatus,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      ethnicity: ethnicity ?? this.ethnicity,
      sexuality: sexuality ?? this.sexuality,
      openToConnectTo: openToConnectTo ?? this.openToConnectTo,
      howDidYouKnowAboutUs: howDidYouKnowAboutUs ?? this.howDidYouKnowAboutUs,
      confirmRealPerson: confirmRealPerson ?? this.confirmRealPerson,
      emailStatus: emailStatus ?? this.emailStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    gender,
    age,
    height,
    ethnicity,
    sexuality,
    openToConnectTo,
    howDidYouKnowAboutUs,
    confirmRealPerson,
    emailStatus,
    passwordStatus,
    formStatus,
  ];
}