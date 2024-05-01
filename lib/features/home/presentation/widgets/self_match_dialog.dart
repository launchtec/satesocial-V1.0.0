import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/styles.dart';
import 'package:sate_social/features/home/domain/repositories/match_repository.dart';
import 'package:sate_social/features/home/domain/use_cases/self_match_case.dart';
import 'package:sate_social/features/home/presentation/blocks/self_match/self_match_cubit.dart';
import 'package:sate_social/features/home/presentation/blocks/self_match/self_match_state.dart';

import '../../../../core/data/blocks/request_status.dart';
import '../../../../core/util/app_constants.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';

class SelfMatchDialog extends StatefulWidget {
  const SelfMatchDialog({super.key});

  @override
  State<SelfMatchDialog> createState() => _SelfMatchDialogState();
}

class _SelfMatchDialogState extends State<SelfMatchDialog> {
  @override
  Widget build(BuildContext context) {
    List<String> religions = [];
    religions.addAll(AppConstants.religions);
    religions.add('Prefer not to say');
    List<String> ethnicities = [];
    ethnicities.addAll(AppConstants.ethnicityList);
    ethnicities.add('Prefer not to say');
    List<String> educations = [];
    educations.addAll(AppConstants.educations);
    educations.add('Prefer not to say');
    List<String> bodyTypes = [];
    bodyTypes.addAll(AppConstants.bodyType);
    bodyTypes.add('Prefer not to say');
    List<String> diets = [];
    diets.addAll(AppConstants.diet);
    diets.add('Prefer not to say');
    List<String> politics = [];
    politics.addAll(AppConstants.politics);
    politics.add('Prefer not to say');

    return BlocProvider(
        create: (context) => SelfMatchCubit(
              selfMatchUseCase: SelfMatchUseCase(
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
          content: BlocBuilder<SelfMatchCubit, SelfMatchState>(
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
                        Text('SELF MATCH INTAKE FORM',
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
                                      oneChoiceDropButton(
                                          blocContext,
                                          'ZODIAC',
                                          'Select answer',
                                          AppConstants.zodiacs,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .zodiacChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'RELIGION',
                                          'Select answer',
                                          religions,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .religionChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'ETHNICITY',
                                          'Select answer',
                                          ethnicities,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .ethnicityChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'EDUCATION',
                                          'Select answer',
                                          educations,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .educationChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'HEIGHT',
                                          'Select answer',
                                          AppConstants.heightList,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .heightChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'BODY TYPE',
                                          'Select answer',
                                          bodyTypes,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .bodyTypeChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'CHILDREN',
                                          'Select answer',
                                          AppConstants.children,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .childrenChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'FAMILY PLANNING',
                                          'Select answer',
                                          AppConstants.familyPlanning,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .familyPlanChanged(value),
                                          50),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'MARIJUANA',
                                          'Select answer',
                                          AppConstants.marijuana,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .marijuanaChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'CIGARETTE SMOKER',
                                          'Select answer',
                                          AppConstants.cigarette,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .smokerCigaretteChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'ALCOHOL',
                                          'Select answer',
                                          AppConstants.alcohol,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .alcoholChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'DIET',
                                          'Select answer',
                                          diets,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .dietChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'POLITICS',
                                          'Select answer',
                                          politics,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .politicsChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'WHAT IS YOUR SELF SATISFACTION LEVEL?',
                                          'Select answer',
                                          AppConstants.satisfactions,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .satisfactionChanged(value),
                                          50),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      Text(
                                          'What features are you most attracted to?',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .features
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .features
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.featuresBody.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .features
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
                                        items: AppConstants.featuresBody
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .features
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeFeaturesChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addFeaturesChanged(
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
                                          'What are your top three physical features?',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .physicalFeatures
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .physicalFeatures
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.featuresBody.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .physicalFeatures
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
                                        items: AppConstants.featuresBody
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .physicalFeatures
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removePhysicalFeaturesChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addPhysicalFeaturesChanged(
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
                                          'Thoughts on Cheating?',
                                          'Select answer',
                                          AppConstants.thoughtsCheating,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .cheatingChanged(value),
                                          50),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      Text('Where are you happiest?',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .happiest
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .happiest
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.happiest.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .happiest
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
                                            AppConstants.happiest.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .happiest
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeHappiestChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addHappiestChanged(
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
                                          'How often do you workout/play sports?',
                                          'Select answer',
                                          AppConstants.workout,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .howOftenWorkoutChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      Text(
                                          'What kinds of vacations do you like to take?',
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
                                          'Select answers (Up to 5)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .vacations
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .vacations
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.vacations.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .vacations
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
                                            AppConstants.vacations.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .vacations
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeVacationsChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addVacationsChanged(
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
                                          'What makes you most interested in a person?',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .mostInterestedInPerson
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .mostInterestedInPerson
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.personInterested
                                              .map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .mostInterestedInPerson
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
                                        items: AppConstants.personInterested
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .mostInterestedInPerson
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeMostInterestedPersonChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addMostInterestedPersonChanged(
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
                                      Text('How do you prefer to dress?',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .dress
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .dress
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.preferDress.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .dress
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
                                        items: AppConstants.preferDress
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .dress
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeDressChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addDressChanged(
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
                                          'How important is sex to you?',
                                          'Select answer',
                                          AppConstants.importantSex,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .importantIsSexChanged(value),
                                          null),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      oneChoiceDropButton(
                                          blocContext,
                                          'Thoughts on Marriage?',
                                          'Select answer',
                                          AppConstants.marriage,
                                          (value) => blocContext
                                              .read<SelfMatchCubit>()
                                              .marriageChanged(value),
                                          50),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                                      Text(
                                          'What do you like to do in your free time?',
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
                                          'Select answers (Up to 5)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .likeToDo
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .likeToDo
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.freeTime.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .likeToDo
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
                                            AppConstants.freeTime.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .likeToDo
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeLikeToDoChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addLikeToDoChanged(
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
                                      Text('Eating behaviors:',
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
                                          'Select answers (Up to 2)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .eatingBehaviors
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .eatingBehaviors
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.eatingBehaviors
                                              .map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .eatingBehaviors
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
                                        items: AppConstants.eatingBehaviors
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .eatingBehaviors
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeEatingBehaviorsChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addEatingBehaviorsChanged(
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
                                          'Reasons for wanting a relationship:',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .reasonsRelationship
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .reasonsRelationship
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants
                                              .reasonsRelationship
                                              .map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .reasonsRelationship
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
                                        items: AppConstants.reasonsRelationship
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .reasonsRelationship
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeReasonsRelationshipChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addReasonsRelationshipChanged(
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
                                      Text('What are your dating intentions?',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .datingIntentions
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .datingIntentions
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.datingIntentions
                                              .map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .datingIntentions
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
                                        items: AppConstants.datingIntentions
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .datingIntentions
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeDatingIntentionsChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addDatingIntentionsChanged(
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
                                      Text('Relationship type',
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
                                          'Select answers (Up to 3)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .relationshipType
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .relationshipType
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.relationshipType
                                              .map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .relationshipType
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
                                        items: AppConstants.relationshipType
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .relationshipType
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeRelationshipTypeChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addRelationshipTypeChanged(
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
                                      Text('Hobbies Passions and Sports:',
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
                                          'Select answers (Unlimited)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .sportsHobbies
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .sportsHobbies
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.sportsHobbies.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .sportsHobbies
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
                                        items: AppConstants.sportsHobbies
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .sportsHobbies
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeSportsHobbiesChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addSportsHobbiesChanged(
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
                                      Text('Music and Concerts:',
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
                                          'Select answers (Unlimited)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .musicHobbies
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .musicHobbies
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.musicHobbies.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .musicHobbies
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
                                        items: AppConstants.musicHobbies
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .musicHobbies
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeMusicHobbiesChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addMusicHobbiesChanged(
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
                                      Text('Hobbies and Interests',
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
                                          'Select answers (Unlimited)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .interestHobbies
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .interestHobbies
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.interestsHobbies
                                              .map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .interestHobbies
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
                                        items: AppConstants.interestsHobbies
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .interestHobbies
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeInterestHobbiesChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addInterestHobbiesChanged(
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
                                      Text('Kinks and Fetishes',
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
                                          'Select answers (Unlimited)',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .fetishes
                                                .isEmpty
                                            ? null
                                            : blocContext
                                                .read<SelfMatchCubit>()
                                                .state
                                                .fetishes
                                                .last,
                                        onChanged: (value) {},
                                        selectedItemBuilder: (context) {
                                          return AppConstants.fetishes.map(
                                            (item) {
                                              return Container(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  blocContext
                                                      .read<SelfMatchCubit>()
                                                      .state
                                                      .fetishes
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
                                            AppConstants.fetishes.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            //disable default onTap to avoid closing menu when selecting an item
                                            enabled: false,
                                            child: StatefulBuilder(
                                              builder: (context, menuSetState) {
                                                final isSelected = blocContext
                                                    .read<SelfMatchCubit>()
                                                    .state
                                                    .fetishes
                                                    .contains(item);
                                                return InkWell(
                                                  onTap: () {
                                                    isSelected
                                                        ? blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .removeFetishesChanged(
                                                                item)
                                                        : blocContext
                                                            .read<
                                                                SelfMatchCubit>()
                                                            .addFetishesChanged(
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
                                    ]))),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        BlocConsumer<SelfMatchCubit, SelfMatchState>(
                            listener: (context, state) {
                          if (state.requestStatus ==
                              RequestStatus.submissionSuccess) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Self match form added successfully',
                                  ),
                                ),
                              );
                            Get.back();
                          }
                        }, builder: (cubitContext, state) {
                          return ElevatedButton(
                              onPressed: () async {
                                cubitContext
                                    .read<SelfMatchCubit>()
                                    .submitSelfMatchForm();
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
