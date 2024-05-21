import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/styles.dart';
import 'package:sate_social/features/home/domain/repositories/match_repository.dart';
import 'package:sate_social/features/home/domain/use_cases/partner_match_case.dart';
import 'package:sate_social/features/home/presentation/blocks/partner_match/partner_match_cubit.dart';
import 'package:sate_social/features/home/presentation/blocks/partner_match/partner_match_state.dart';
import 'package:sate_social/features/home/presentation/blocks/self_match/self_match_cubit.dart';
import 'package:sate_social/features/home/presentation/blocks/self_match/self_match_state.dart';

import '../../../../core/data/blocks/request_status.dart';
import '../../../../core/util/app_constants.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';

class PartnerMatchDialog extends StatefulWidget {
  const PartnerMatchDialog({super.key});

  @override
  State<PartnerMatchDialog> createState() => _PartnerMatchDialogState();
}

class _PartnerMatchDialogState extends State<PartnerMatchDialog> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => PartnerMatchCubit(
          partnerMatchUseCase: PartnerMatchUseCase(
            matchRepository: context.read<MatchRepository>(),
          ),
        ),
        child: AlertDialog(
          insetPadding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.radiusMaxLarge))),
          titleTextStyle: TextStyle(
              fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
          content: BlocBuilder<PartnerMatchCubit, PartnerMatchState>(
              builder: (blocContext, state) {
                return Container(
                    width: context.width,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radiusMaxLarge)),
                    ),
                    child: Stack(children: [
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: ColorConstants.matchPalette,
                            ),
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.radiusMaxLarge)),
                          ),
                          child: Column(mainAxisSize: MainAxisSize.max, children: [
                            const SizedBox(
                                height: Dimensions.paddingSizeMiddleSmall),
                            Image.asset(Images.match, height: 50),
                            const SizedBox(
                                height: Dimensions.paddingSizeMiddleSmall),
                            Text('PARTNER MATCH INTAKE FORM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: Dimensions.paddingSizeLarge),
                            Expanded(
                                child: RawScrollbar(
                                    thickness: 3.0,
                                    crossAxisMargin: 1.0,
                                    thumbColor: Colors.white,
                                    child: ListView(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                            Dimensions.paddingSizeLarge),
                                        children: [
                                          Text(
                                              'Religion',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                  Dimensions.fontSizeDefault,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          DropdownButtonFormField2<String>(
                                            isExpanded: true,
                                            style: TextStyle(
                                                fontSize:
                                                Dimensions.fontSizeDefault,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none),
                                            buttonStyleData: const ButtonStyleData(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          color: Colors.black54,
                                                          blurRadius: 15.0,
                                                          offset: Offset(0.0, 0.75))
                                                    ],
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(Dimensions
                                                            .radiusLarge))),
                                                padding: EdgeInsets.zero),
                                            hint: const Text(
                                              'Select answers',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .religions
                                                .isEmpty
                                                ? null
                                                : blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .religions
                                                .last,
                                            onChanged: (value) {},
                                            selectedItemBuilder: (context) {
                                              return AppConstants.religions.map(
                                                    (item) {
                                                  return Container(
                                                    alignment:
                                                    AlignmentDirectional.center,
                                                    child: Text(
                                                      blocContext
                                                          .read<PartnerMatchCubit>()
                                                          .state
                                                          .religions
                                                          .join(', '),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  );
                                                },
                                              ).toList();
                                            },
                                            items: AppConstants.religions
                                                .map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                //disable default onTap to avoid closing menu when selecting an item
                                                enabled: false,
                                                child: StatefulBuilder(
                                                  builder: (context, menuSetState) {
                                                    final isSelected = blocContext
                                                        .read<PartnerMatchCubit>()
                                                        .state
                                                        .religions
                                                        .contains(item);
                                                    return InkWell(
                                                      onTap: () {
                                                        isSelected
                                                            ? blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .removeReligionsChanged(
                                                            item)
                                                            : blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .addReligionsChanged(
                                                            item);
                                                        setState(() {});
                                                        menuSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: double.infinity,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16.0),
                                                        child: Row(
                                                          children: [
                                                            if (isSelected)
                                                              const Icon(Icons
                                                                  .check_box_outlined)
                                                            else
                                                              const Icon(Icons
                                                                  .check_box_outline_blank),
                                                            const SizedBox(
                                                                width: 16),
                                                            Expanded(
                                                              child: Text(
                                                                item,
                                                                style:
                                                                const TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.paddingSizeSmall),
                                          Text(
                                              'Ethnicity',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                  Dimensions.fontSizeDefault,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          DropdownButtonFormField2<String>(
                                            isExpanded: true,
                                            style: TextStyle(
                                                fontSize:
                                                Dimensions.fontSizeDefault,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none),
                                            buttonStyleData: const ButtonStyleData(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          color: Colors.black54,
                                                          blurRadius: 15.0,
                                                          offset: Offset(0.0, 0.75))
                                                    ],
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(Dimensions
                                                            .radiusLarge))),
                                                padding: EdgeInsets.zero),
                                            hint: const Text(
                                              'Select answers',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .ethnicities
                                                .isEmpty
                                                ? null
                                                : blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .ethnicities
                                                .last,
                                            onChanged: (value) {},
                                            selectedItemBuilder: (context) {
                                              return AppConstants.ethnicityList.map(
                                                    (item) {
                                                  return Container(
                                                    alignment:
                                                    AlignmentDirectional.center,
                                                    child: Text(
                                                      blocContext
                                                          .read<PartnerMatchCubit>()
                                                          .state
                                                          .ethnicities
                                                          .join(', '),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  );
                                                },
                                              ).toList();
                                            },
                                            items: AppConstants.ethnicityList
                                                .map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                //disable default onTap to avoid closing menu when selecting an item
                                                enabled: false,
                                                child: StatefulBuilder(
                                                  builder: (context, menuSetState) {
                                                    final isSelected = blocContext
                                                        .read<PartnerMatchCubit>()
                                                        .state
                                                        .ethnicities
                                                        .contains(item);
                                                    return InkWell(
                                                      onTap: () {
                                                        isSelected
                                                            ? blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .removeEthnicitiesChanged(
                                                            item)
                                                            : blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .addEthnicitiesChanged(
                                                            item);
                                                        setState(() {});
                                                        menuSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: double.infinity,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16.0),
                                                        child: Row(
                                                          children: [
                                                            if (isSelected)
                                                              const Icon(Icons
                                                                  .check_box_outlined)
                                                            else
                                                              const Icon(Icons
                                                                  .check_box_outline_blank),
                                                            const SizedBox(
                                                                width: 16),
                                                            Expanded(
                                                              child: Text(
                                                                item,
                                                                style:
                                                                const TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.paddingSizeSmall),
                                          Text('Education',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                  Dimensions.fontSizeDefault,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          DropdownButtonFormField2<String>(
                                            isExpanded: true,
                                            style: TextStyle(
                                                fontSize:
                                                Dimensions.fontSizeDefault,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none),
                                            buttonStyleData: const ButtonStyleData(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          color: Colors.black54,
                                                          blurRadius: 15.0,
                                                          offset: Offset(0.0, 0.75))
                                                    ],
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(Dimensions
                                                            .radiusLarge))),
                                                padding: EdgeInsets.zero),
                                            hint: const Text(
                                              'Select answers',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .educations
                                                .isEmpty
                                                ? null
                                                : blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .educations
                                                .last,
                                            onChanged: (value) {},
                                            selectedItemBuilder: (context) {
                                              return AppConstants.educations.map(
                                                    (item) {
                                                  return Container(
                                                    alignment:
                                                    AlignmentDirectional.center,
                                                    child: Text(
                                                      blocContext
                                                          .read<PartnerMatchCubit>()
                                                          .state
                                                          .educations
                                                          .join(', '),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  );
                                                },
                                              ).toList();
                                            },
                                            items:
                                            AppConstants.educations.map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                //disable default onTap to avoid closing menu when selecting an item
                                                enabled: false,
                                                child: StatefulBuilder(
                                                  builder: (context, menuSetState) {
                                                    final isSelected = blocContext
                                                        .read<PartnerMatchCubit>()
                                                        .state
                                                        .educations
                                                        .contains(item);
                                                    return InkWell(
                                                      onTap: () {
                                                        isSelected
                                                            ? blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .removeEducationsChanged(
                                                            item)
                                                            : blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .addEducationsChanged(
                                                            item);
                                                        setState(() {});
                                                        menuSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: double.infinity,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16.0),
                                                        child: Row(
                                                          children: [
                                                            if (isSelected)
                                                              const Icon(Icons
                                                                  .check_box_outlined)
                                                            else
                                                              const Icon(Icons
                                                                  .check_box_outline_blank),
                                                            const SizedBox(
                                                                width: 16),
                                                            Expanded(
                                                              child: Text(
                                                                item,
                                                                style:
                                                                const TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.paddingSizeSmall),
                                          oneChoiceDropButton(
                                              blocContext,
                                              'Age',
                                              'Select answer',
                                              AppConstants.ageList,
                                                  (value) => blocContext
                                                  .read<PartnerMatchCubit>()
                                                  .ageChanged(value),
                                              null),
                                          const SizedBox(
                                              height: Dimensions.paddingSizeSmall),
                                          Text(
                                              'Body types I’m attracted to:',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                  Dimensions.fontSizeDefault,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          DropdownButtonFormField2<String>(
                                            isExpanded: true,
                                            style: TextStyle(
                                                fontSize:
                                                Dimensions.fontSizeDefault,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none),
                                            buttonStyleData: const ButtonStyleData(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          color: Colors.black54,
                                                          blurRadius: 15.0,
                                                          offset: Offset(0.0, 0.75))
                                                    ],
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(Dimensions
                                                            .radiusLarge))),
                                                padding: EdgeInsets.zero),
                                            hint: const Text(
                                              'Select answers (Up to 4)',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .bodyTypes
                                                .isEmpty
                                                ? null
                                                : blocContext
                                                .read<PartnerMatchCubit>()
                                                .state
                                                .bodyTypes
                                                .last,
                                            onChanged: (value) {},
                                            selectedItemBuilder: (context) {
                                              return AppConstants.bodyType.map(
                                                    (item) {
                                                  return Container(
                                                    alignment:
                                                    AlignmentDirectional.center,
                                                    child: Text(
                                                      blocContext
                                                          .read<PartnerMatchCubit>()
                                                          .state
                                                          .bodyTypes
                                                          .join(', '),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  );
                                                },
                                              ).toList();
                                            },
                                            items:
                                            AppConstants.bodyType.map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                //disable default onTap to avoid closing menu when selecting an item
                                                enabled: false,
                                                child: StatefulBuilder(
                                                  builder: (context, menuSetState) {
                                                    final isSelected = blocContext
                                                        .read<PartnerMatchCubit>()
                                                        .state
                                                        .bodyTypes
                                                        .contains(item);
                                                    return InkWell(
                                                      onTap: () {
                                                        isSelected
                                                            ? blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .removeBodyTypesChanged(
                                                            item)
                                                            : blocContext
                                                            .read<
                                                            PartnerMatchCubit>()
                                                            .addBodyTypesChanged(
                                                            item);
                                                        setState(() {});
                                                        menuSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: double.infinity,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16.0),
                                                        child: Row(
                                                          children: [
                                                            if (isSelected)
                                                              const Icon(Icons
                                                                  .check_box_outlined)
                                                            else
                                                              const Icon(Icons
                                                                  .check_box_outline_blank),
                                                            const SizedBox(
                                                                width: 16),
                                                            Expanded(
                                                              child: Text(
                                                                item,
                                                                style:
                                                                const TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.paddingSizeSmall),
                                          oneChoiceDropButton(
                                              blocContext,
                                              'Diet',
                                              'Select answer',
                                              AppConstants.diet,
                                                  (value) => blocContext
                                                  .read<PartnerMatchCubit>()
                                                  .dietChanged(value),
                                              null),
                                          const SizedBox(
                                              height: Dimensions.paddingSizeSmall),
                                          oneChoiceDropButton(
                                              blocContext,
                                              'Politics',
                                              'Select answer',
                                              AppConstants.politics,
                                                  (value) => blocContext
                                                  .read<PartnerMatchCubit>()
                                                  .politicsChanged(value),
                                              null),
                                        ]))),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            BlocConsumer<PartnerMatchCubit, PartnerMatchState>(
                                listener: (context, state) {
                                  if (state.requestStatus ==
                                      RequestStatus.submissionSuccess) {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Partner match form added successfully',
                                          ),
                                        ),
                                      );
                                    Get.back();
                                  }
                                }, builder: (cubitContext, state) {
                              return ElevatedButton(
                                  onPressed: () async {
                                    cubitContext
                                        .read<PartnerMatchCubit>()
                                        .submitPartnerMatchForm();
                                  },
                                  style: ButtonStyle(
                                      padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeMiddleSmall)),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ColorConstants.primaryColor)),
                                  child: Container(
                                      width: context.width / 5,
                                      child: Text('Submit',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Dimensions.fontSizeSmall,
                                              color: Colors.white))));
                            }),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                          ])),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                            padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            icon: const Icon(Icons.close,
                                color: Colors.white, size: 32),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ]),
                    ]));
              }),
          actions: null,
        ));
  }

  Widget oneChoiceDropButton(
      BuildContext blocContext,
      String title,
      String hint,
      List<String> valueList,
      ValueChanged<String> changeCallback,
      double? heightButton) {
    return Column(children: [
      Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: Dimensions.fontSizeDefault,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
      DropdownButtonFormField2<String>(
        isExpanded: true,
        style: TextStyle(
            fontSize: Dimensions.fontSizeDefault, color: Colors.black),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero, border: InputBorder.none),
        buttonStyleData: ButtonStyleData(
            height: heightButton ?? 30,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 0.75))
                ],
                borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.radiusLarge))),
            padding: EdgeInsets.zero),
        hint: Text(
          hint,
          style: const TextStyle(fontSize: 14),
        ),
        onChanged: (String? value) => changeCallback(value!),
        dropdownStyleData: const DropdownStyleData(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.radiusLarge)))),
        items: valueList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      )
    ]);
  }
}
