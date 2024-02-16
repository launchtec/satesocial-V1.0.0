import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/dimensions.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_up_use_case.dart';
import '../blocks/email_status.dart';
import '../blocks/form_status.dart';
import '../blocks/password_status.dart';
import '../blocks/sign_up/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        signUpUseCase: SignUpUseCase(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  Timer? debounce;

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.invalid) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Invalid form: please fill in all fields'),
                ),
              );
          }
          if (state.formStatus == FormStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'There was an error with the sign up process. Try again.',
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeExtraLarge),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  key: const Key('signUp_nameInput_textField'),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    hintText: 'Name',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (String value) {
                      context.read<SignUpCubit>().nameChanged(value);
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                TextFormField(
                  key: const Key('signUp_emailInput_textField'),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    hintText: 'Email',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorText: state.emailStatus == EmailStatus.invalid
                        ? 'Invalid email'
                        : null,
                  ),
                  onChanged: (String value) {
                    if (debounce?.isActive ?? false) debounce?.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), () {
                      context.read<SignUpCubit>().emailChanged(value);
                    });
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                TextFormField(
                  key: const Key('signUp_passwordInput_textField'),
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    hintText: 'Password',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorText: state.passwordStatus == PasswordStatus.invalid
                        ? 'Invalid password'
                        : null,
                  ),
                  onChanged: (String value) {
                    context.read<SignUpCubit>().passwordChanged(value);
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint: const Text(
                    'Select Your Gender',
                    style: TextStyle(fontSize: 14),
                  ),
                  onChanged: (String? value) {
                    context.read<SignUpCubit>().genderChanged(value!);
                  },
                  items: AppConstants.genderList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint: const Text(
                    'Select Your Ethnicity',
                    style: TextStyle(fontSize: 14),
                  ),
                  onChanged: (String? value) {
                    context.read<SignUpCubit>().genderChanged(value!);
                  },
                  items: AppConstants.ethnicityList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint: const Text(
                    'Select Your Sexuality',
                    style: TextStyle(fontSize: 14),
                  ),
                  onChanged: (String? value) {
                    context.read<SignUpCubit>().genderChanged(value!);
                  },
                  items: AppConstants.sexualityList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint: const Text(
                    'Open To Connect To?',
                    style: TextStyle(fontSize: 14),
                  ),
                  onChanged: (String? value) {
                    context.read<SignUpCubit>().genderChanged(value!);
                  },
                  items: AppConstants.openToConnectToList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                TextFormField(
                  key: const Key('signUp_howDidYouKnowAboutUsInput_textField'),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'How Did You Hear About Us?',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                  ),
                  onChanged: (String value) {
                    context.read<SignUpCubit>().howDidYouKnowAboutUsChanged(value);
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                Center(child: SizedBox(width: context.width / 2,child: ElevatedButton(
                  key: const Key('signUp_continue_elevatedButton'),
                  onPressed: context.read<SignUpCubit>().state.formStatus ==
                      FormStatus.submissionInProgress
                      ? null
                      : () {
                    context.read<SignUpCubit>().signUp();
                  },
                  child: const Text('Sign Up'),
                ))),
              ],
            ),
          );
        },
      ),
    );
  }
}