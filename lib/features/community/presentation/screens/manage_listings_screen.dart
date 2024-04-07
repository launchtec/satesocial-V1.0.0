import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/community/domain/use_cases/get_posts_case.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../domain/repositories/post_repository.dart';
import '../blocks/get_posts/get_posts_cubit.dart';

class ManageListingsScreen extends StatelessWidget {
  const ManageListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPostsCubit(
        getPostsCase: GetPostsCase(
          postRepository: context.read<PostRepository>(),
        ),
      ),
      child: const ManageListingsView(),
    );
  }
}

class ManageListingsView extends StatefulWidget {
  const ManageListingsView({super.key});

  @override
  State<ManageListingsView> createState() => _ManageListingsViewState();
}

class _ManageListingsViewState extends State<ManageListingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: Container(
            padding:
                const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.cover,
                  opacity: 0.4),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.grey)),
                  Image.asset(Images.logo, height: 65),
                ]),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text(Get.find<String>(tag: 'city') ?? '',
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
              const Divider(
                  color: Colors.grey,
                  thickness: 5,
                  height: Dimensions.paddingSizeExtraSmall)
            ])));
  }
}
