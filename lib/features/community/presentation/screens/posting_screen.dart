import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/community/domain/repositories/post_repository.dart';
import 'package:sate_social/features/community/domain/use_cases/upload_doc_case.dart';
import 'package:sate_social/features/community/presentation/blocks/create_post/create_post_cubit.dart';
import 'package:sate_social/features/community/presentation/blocks/create_post/create_post_state.dart';
import 'package:sate_social/features/community/presentation/widgets/groups_view_dialog.dart';

import '../../../../core/common_widgets/alert_dialogs.dart';
import '../../../../core/util/app_constants.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../domain/use_cases/add_post_use_case.dart';

class PostingScreen extends StatelessWidget {
  const PostingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(
          addPostUseCase: AddPostUseCase(
            postRepository: context.read<PostRepository>(),
          ),
          uploadDocUseCase: UploadDocUseCase(
            postRepository: context.read<PostRepository>()
          )),
      child: const PostingView(),
    );
  }
}

class PostingView extends StatefulWidget {
  const PostingView({super.key});

  @override
  State<PostingView> createState() => _PostingViewState();
}

class _PostingViewState extends State<PostingView> {
  late String city;
  final focusNode = FocusNode();
  List<String> postGroups = AppConstants.romanceGroups;

  @override
  void initState() {
    try {
      city = Get.find<String>(tag: 'city');
    } catch (exception) {
      city = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
            appBar: null,
            backgroundColor: ColorConstants.backColor,
            body: BlocConsumer<CreatePostCubit, CreatePostState>(
                listener: (context, state) {
              if (state.requestStatus == RequestStatus.submissionSuccess) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Post added successfully',
                      ),
                    ),
                  );
                Get.back();
              }
            }, builder: (cubitContext, state) {
              return Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: ListView(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.grey)),
                            Image.asset(Images.logo, height: 65),
                          ]),
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: Dimensions.paddingSizeExtraLarge),
                              child: Text(city,
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeTitle,
                                      shadows: const [
                                        Shadow(
                                          color: Colors
                                              .black, // Choose the color of the shadow
                                          blurRadius:
                                              2.0, // Adjust the blur radius for the shadow effect
                                          offset: Offset(-4.0,
                                              1.0), // Set the horizontal and vertical offset for the shadow
                                        ),
                                      ],
                                      color: ColorConstants.secondColor)))
                        ]),
                    const Divider(color: Colors.grey, thickness: 5),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Center(
                        child: Text('Community Posting',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeOverLarge,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      decoration: const BoxDecoration(
                        color: ColorConstants.shapeColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radiusLarge)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            cubitContext.read<CreatePostCubit>().isGigCategory()
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Text('POST A JOB',
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .fontSizeExtraLarge,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                            width: Dimensions.paddingSizeSmall),
                                        Text('\$4.99/per post',
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .fontSizeExtraLarge,
                                                color:
                                                    ColorConstants.greenAccent,
                                                fontWeight: FontWeight.bold)),
                                      ])
                                : const SizedBox(),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault),
                                child: Row(children: [
                                  Text('Category: ',
                                      style: TextStyle(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                      child: DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.fontSizeSmall),
                                    buttonStyleData: const ButtonStyleData(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    Dimensions.radiusSmall))),
                                        padding: EdgeInsets.zero),
                                    value: cubitContext
                                        .read<CreatePostCubit>()
                                        .state
                                        .category,
                                    onChanged: (String? value) {
                                      updatePostGroupsList(
                                          cubitContext, value!);
                                      cubitContext
                                          .read<CreatePostCubit>()
                                          .categoryChanged(value);
                                    },
                                    items: AppConstants.postCategories
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                  )),
                                ])),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault),
                                child: Row(children: [
                                  Text(
                                      cubitContext
                                              .read<CreatePostCubit>()
                                              .isGigCategory()
                                          ? 'Select Industry: '
                                          : 'Select Post Group: ',
                                      style: TextStyle(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                      child: cubitContext
                                              .read<CreatePostCubit>()
                                              .isSocialCategory()
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  backgroundColor: Colors.white,
                                                  textStyle: TextStyle(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radiusMiddle),
                                                  )),
                                              onPressed: () {
                                                showDialog(
                                                    barrierDismissible: true,
                                                    context: cubitContext,
                                                    builder: (context) {
                                                      return GroupsViewDialog(
                                                        socialGroups:
                                                            AppConstants
                                                                .socialGroups,
                                                        postState: cubitContext
                                                            .read<
                                                                CreatePostCubit>()
                                                            .state,
                                                        selectCategory:
                                                            (category) {
                                                          cubitContext
                                                              .read<
                                                                  CreatePostCubit>()
                                                              .groupChanged(
                                                                  category
                                                                      .name);
                                                        },
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                  context
                                                      .read<CreatePostCubit>()
                                                      .state
                                                      .group!,
                                                  textAlign: TextAlign.center))
                                          : DropdownButtonFormField2<String>(
                                              isExpanded: true,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: InputBorder.none),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                              buttonStyleData: const ButtonStyleData(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              Dimensions
                                                                  .radiusSmall))),
                                                  padding: EdgeInsets.zero),
                                              value: cubitContext
                                                  .read<CreatePostCubit>()
                                                  .state
                                                  .group,
                                              onChanged: (String? value) {
                                                cubitContext
                                                    .read<CreatePostCubit>()
                                                    .groupChanged(value!);
                                              },
                                              items: postGroups.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value));
                                              }).toList(),
                                            ))
                                ])),
                            cubitContext.read<CreatePostCubit>().isGigCategory()
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault),
                                    child: Row(children: [
                                      Text('Rate: ',
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.fontSizeExtraLarge,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                          child: TextField(
                                        key:
                                            const Key('post_zipCode_textField'),
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.fontSizeDefault),
                                        decoration: InputDecoration(
                                          filled: true,
                                          isDense: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: Dimensions
                                                      .paddingSizeSmall,
                                                  horizontal: Dimensions
                                                      .paddingSizeSmall),
                                          hintText: 'Type In',
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  Dimensions.fontSizeDefault),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (String value) {
                                          context
                                              .read<CreatePostCubit>()
                                              .rateChanged(value);
                                        },
                                      ))
                                    ]))
                                : const SizedBox(),
                            cubitContext.read<CreatePostCubit>().isGigCategory()
                                ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault),
                                child: Row(children: [
                                  Text('Employment type: ',
                                      style: TextStyle(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                      child: DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.fontSizeSmall),
                                    buttonStyleData: const ButtonStyleData(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    Dimensions.radiusSmall))),
                                        padding: EdgeInsets.zero),
                                    value: cubitContext
                                        .read<CreatePostCubit>()
                                        .state
                                        .employmentType,
                                    onChanged: (String? value) {
                                      cubitContext
                                          .read<CreatePostCubit>()
                                          .employmentTypeChanged(value!);
                                    },
                                    items: AppConstants.employmentTypes
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                  ))
                                ])) : const SizedBox(),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault),
                                child: Text('Posting Title:',
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault),
                                child: TextField(
                                  key: const Key('post_postingTitle_textField'),
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault),
                                  decoration: InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: Dimensions.paddingSizeSmall,
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    hintText: 'Type In',
                                    hintStyle: TextStyle(
                                        fontSize: Dimensions.fontSizeDefault),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (String value) {
                                    cubitContext
                                        .read<CreatePostCubit>()
                                        .titleChanged(value);
                                  },
                                )),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault),
                                child: Row(children: [
                                  Text('Zip Code: ',
                                      style: TextStyle(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                      child: TextField(
                                    key: const Key('post_zipCode_textField'),
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeDefault),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeSmall,
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                      hintText: 'Type In',
                                      hintStyle: TextStyle(
                                          fontSize: Dimensions.fontSizeDefault),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (String value) {
                                      cubitContext
                                          .read<CreatePostCubit>()
                                          .zipCodeChanged(value);
                                    },
                                  ))
                                ])),
                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),
                          ]),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraLarge),
                        child: Row(children: [
                          Text('Post:',
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ])),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        child: TextField(
                          key: const Key('post_zipCode_textField'),
                          focusNode: focusNode,
                          style:
                              TextStyle(fontSize: Dimensions.fontSizeDefault),
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeDefault,
                                horizontal: Dimensions.paddingSizeSmall),
                            hintText: 'Type In',
                            hintStyle:
                                TextStyle(fontSize: Dimensions.fontSizeDefault),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radiusLarge),
                            ),
                          ),
                          onChanged: (String value) {
                            cubitContext
                                .read<CreatePostCubit>()
                                .contentChanged(value);
                          },
                        )),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraLarge),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cubitContext
                                      .read<CreatePostCubit>()
                                      .isGigCategory()
                                  ? cubitContext
                                  .read<CreatePostCubit>().state.uploadDoc == null ? InkWell(
                                      child: Column(children: [
                                        Image.asset(Images.addDoc),
                                        Text('Add Doc',
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform
                                                .pickFiles();

                                        if (result != null) {
                                          File file = File(result.files.single.path!);
                                          cubitContext.read<CreatePostCubit>()
                                              .uploadDocChanged(file);
                                        }
                                      }) : Column(children: [
                                const Icon(Icons.check, color: ColorConstants.greenAccent),
                                Text('File selected',
                                    style: TextStyle(
                                        fontSize:
                                        Dimensions.fontSizeSmall,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ])
                                  : const SizedBox(),
                              ElevatedButton(
                                  onPressed: () {
                                    AlertDialogs.showLoaderDialog(cubitContext);
                                    cubitContext
                                        .read<CreatePostCubit>()
                                        .submitPost();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              ColorConstants.primaryColor)),
                                  child: const Text('Submit',
                                      style: TextStyle(color: Colors.white)))
                            ]))
                  ]));
            })));
  }

  void updatePostGroupsList(BuildContext context, String value) {
    setState(() {
      if (value == 'Romance Posting') {
        postGroups = AppConstants.romanceGroups;
        context
            .read<CreatePostCubit>()
            .groupChanged(AppConstants.romanceGroups[0]);
      } else if (value == 'Social & Activity Posting') {
        postGroups = [];
        context
            .read<CreatePostCubit>()
            .groupChanged(AppConstants.socialGroups[0].name);
      } else {
        postGroups = AppConstants.gigIndustries;
        context
            .read<CreatePostCubit>()
            .groupChanged(AppConstants.gigIndustries[0]);
      }
    });
  }
}
