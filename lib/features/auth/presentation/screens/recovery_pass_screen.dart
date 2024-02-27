import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/auth/domain/use_cases/recovery_pass_use_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/recovery_pass/recovery_pass_cubit.dart';

import '../../../../core/util/dimensions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../blocks/email_status.dart';
import '../blocks/form_status.dart';
import '../blocks/recovery_pass/recovery_pass_state.dart';

class RecoveryPassScreen extends StatelessWidget {
  const RecoveryPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecoveryPassCubit(
        recoveryPassUseCase: RecoveryPassUseCase(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      child: const RecoveryPassView(),
    );
  }
}

class RecoveryPassView extends StatefulWidget {
  const RecoveryPassView({super.key});

  @override
  State<RecoveryPassView> createState() => _RecoveryPassViewState();
}

class _RecoveryPassViewState extends State<RecoveryPassView> {
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
          title: const Text('Recovery Account'),
        ),
        body: BlocConsumer<RecoveryPassCubit, RecoveryPassState>(
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
        }, builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeDefault,
                  horizontal: Dimensions.paddingSizeExtraLarge),
              child: Column(children: [
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
                      context.read<RecoveryPassCubit>().emailChanged(value);
                    });
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                Center(
                    child: SizedBox(
                        width: context.width / 2,
                        child: ElevatedButton(
                          key: const Key('recoveryPass_continue_elevatedButton'),
                          onPressed:
                          context.read<RecoveryPassCubit>().state.formStatus ==
                              FormStatus.submissionInProgress
                              ? null
                              : () {
                            context.read<RecoveryPassCubit>().accountRecovery();
                          },
                          child: const Text('Send Recovery Link'),
                        ))),
              ]));
        }));
  }
}
