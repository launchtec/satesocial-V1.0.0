import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/dimensions.dart';

import '../../../../core/route/route_helper.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/domain/use_cases/sign_out_use_case.dart';
import '../../../auth/presentation/blocks/sign_out/sign_out_cubit.dart';
import '../../../auth/presentation/blocks/sign_out/sign_out_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(
        signOutUseCase: SignOutUseCase(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: BlocConsumer<SignOutCubit, SignOutState>(
            listener: (context, state) {
              if (state is SuccessSignOutState) {
                Get.offAndToNamed(RouteHelper.getWelcomeRoute());
              }
            },
            builder: (context, state) {
              return Center(
                  child: Column(children: [
                const SizedBox(height: Dimensions.paddingBigTop),
                ElevatedButton(
                    onPressed: () {
                      context.read<SignOutCubit>().signOut();
                    },
                    child: const Text('Log Out'))
              ]));
            }));
  }
}
