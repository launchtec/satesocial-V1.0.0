import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/dimensions.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_in_use_case.dart';
import '../blocks/email_status.dart';
import '../blocks/form_status.dart';
import '../blocks/password_status.dart';
import '../blocks/sign_in/sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        signInUseCase: SignInUseCase(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
        title: const Text('Sign In'),
      ),
      body: BlocConsumer<SignInCubit, SignInState>(
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
                    'There was an error with the sign in process. Try again.',
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeExtraLarge),
            child: Column(
              children: [
                TextFormField(
                  key: const Key('signIn_emailInput_textField'),
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
                      context.read<SignInCubit>().emailChanged(value);
                    });
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                TextFormField(
                  key: const Key('signIn_passwordInput_textField'),
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
                    context.read<SignInCubit>().passwordChanged(value);
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                Center(
                    child: SizedBox(
                        width: context.width / 2,
                        child: ElevatedButton(
                          key: const Key('signIn_continue_elevatedButton'),
                          onPressed:
                              context.read<SignInCubit>().state.formStatus ==
                                      FormStatus.submissionInProgress
                                  ? null
                                  : () {
                                      context.read<SignInCubit>().signIn();
                                    },
                          child: const Text('Sign In'),
                        ))),
                const SizedBox(height: Dimensions.paddingSizeMiddleSmall),
                InkWell(
                    child: const Text('Forgot Password',
                        style: TextStyle(color: Colors.blueAccent)),
                    onTap: () {})
              ],
            ),
          );
        },
      ),
    );
  }
}
