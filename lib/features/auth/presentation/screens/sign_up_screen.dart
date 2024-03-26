import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_selfie_liveness/selfie_liveness.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/dimensions.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/images.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_up_use_case.dart';
import '../blocks/email_status.dart';
import '../../../../core/data/blocks/form_status.dart';
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
  String value = "";
  int currentStep = 0;
  Timer? debounce;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void dispose() {
    debounce?.cancel();
    _ageController.dispose();
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
            if (state.formStatus == FormStatus.faceNotValid) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Invalid form: go through identity verification'),
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
            if (state.formStatus == FormStatus.submissionSuccess) {
              Get.toNamed(
                  RouteHelper.getDashboardRoute());
            }
          },
          builder: (context, state) {
            return Container(
                padding: const EdgeInsets.all(20),
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepCancel: () => currentStep == 0
                      ? null
                      : setState(() {
                          currentStep -= 1;
                        }),
                  onStepContinue: () {
                    bool completeStep = context.read<SignUpCubit>().checkStepComplete(currentStep);
                    if (completeStep) {
                      bool isLastStep = (currentStep == 2);
                      if (isLastStep) {
                        context.read<SignUpCubit>().signUp();
                      } else {
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    }
                  },
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  steps: getSteps(state),
                ));
          }),
    );
  }

  List<Step> getSteps(SignUpState state) {
    return <Step>[
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Sign Up"),
          content: Column(children: [
            TextFormField(
              key: const Key('signUp_nameInput_textField'),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Name\*',
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
                hintText: 'Email\*',
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
                hintText: 'Password\*',
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
          ])),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Profile"),
        content: Column(children: [
          TextFormField(
            key: const Key('signUp_ageInput_textField'),
            controller: _ageController,
            showCursor: true,
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              hintText: 'Age\*',
              hintStyle: const TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onTap: () async {
              final result = await showMaterialNumberPicker(
                  context: context,
                  minNumber: 18,
                  maxNumber: 120,
                  title: 'Select Age');
              if (result != null) {
                _ageController.text = "Age: $result";
                context.read<SignUpCubit>().ageChanged(result);
              }
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
              'Height',
              style: TextStyle(fontSize: 14),
            ),
            onChanged: (String? value) {
              context.read<SignUpCubit>().heightChanged(value!);
            },
            items: AppConstants.heightList
                .map<DropdownMenuItem<String>>((String value) {
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
              'Select Your Gender\*',
              style: TextStyle(fontSize: 14),
            ),
            onChanged: (String? value) {
              context.read<SignUpCubit>().genderChanged(value!);
            },
            items: AppConstants.genderList
                .map<DropdownMenuItem<String>>((String value) {
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
              context.read<SignUpCubit>().ethnicityChanged(value!);
            },
            items: AppConstants.ethnicityList
                .map<DropdownMenuItem<String>>((String value) {
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
              'Select Your Sexuality\*',
              style: TextStyle(fontSize: 14),
            ),
            onChanged: (String? value) {
              context.read<SignUpCubit>().sexualityChanged(value!);
            },
            items: AppConstants.sexualityList
                .map<DropdownMenuItem<String>>((String value) {
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
              'Open To Connect To?\*',
              style: TextStyle(fontSize: 14),
            ),
            onChanged: (String? value) {
              context.read<SignUpCubit>().openToConnectToChanged(value!);
            },
            items: AppConstants.openToConnectToList
                .map<DropdownMenuItem<String>>((String value) {
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
        ]),
      ),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Identity"),
          content: value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeDefault),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(Images.complete),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text("Identification completed successfully",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: Dimensions.fontSizeLarge)),
                      ]))
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeDefault),
                  child: Column(children: [
                    Text("Click on the button to complete the check",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.fontSizeLarge)),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    ElevatedButton(
                        onPressed: () async {
                          value = await SelfieLiveness.detectLiveness(
                            poweredBy: "Sate Social",
                            assetLogo: Images.logo,
                            compressQualityandroid: 88,
                            compressQualityiOS: 88,
                          );
                          if (value.isNotEmpty) {
                            setState(() {
                              context
                                  .read<SignUpCubit>()
                                  .confirmRealPersonChanged(true);
                            });
                          }
                        },
                        child: const Text("Detect Liveness\*")),
                  ]))),
    ];
  }
}
