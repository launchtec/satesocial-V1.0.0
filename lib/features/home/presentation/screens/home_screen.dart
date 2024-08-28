import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/use_cases/update_buy_match_case.dart';
import 'package:sate_social/features/home/presentation/widgets/match_form_dialog.dart';
import 'package:sate_social/features/home/presentation/widgets/partner_match_dialog.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/domain/use_cases/user_info_case.dart';
import '../../../auth/presentation/blocks/update_activity/update_activity_cubit.dart';
import '../../../auth/presentation/blocks/user_info/user_info_cubit.dart';
import '../blocks/purchase_match/purchase_match_cubit.dart';
import '../blocks/purchase_match/purchase_match_state.dart';
import '../widgets/self_match_dialog.dart';

class HomeScreen extends StatelessWidget {
  final PageController navController;
  final bool isShowMatch;
  const HomeScreen(
      {super.key, required this.navController, required this.isShowMatch});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserInfoCubit(
                  userInfoCase: UserInfoCase(
                    authRepository: context.read<AuthRepository>(),
                  ),
                )),
        BlocProvider(
            create: (context) => PurchaseMatchCubit(
                    updateBuyMatchCase: UpdateBuyMatchCase(
                  authRepository: context.read<AuthRepository>(),
                )))
      ],
      child: HomeView(navController: navController, isShowMatch: isShowMatch),
    );
  }
}

class HomeView extends StatefulWidget {
  final PageController navController;
  final bool isShowMatch;
  const HomeView(
      {super.key, required this.navController, required this.isShowMatch});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSelfFormGlobal = false;
  AppUser? appUser;

  @override
  void initState() {
    super.initState();
    context.read<UpdateActivityCubit>().updateActivity();
    context.read<UserInfoCubit>().getUserInfo().then((user) => appUser = user);
    if (widget.isShowMatch) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => showMatchDialog(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: BlocConsumer<PurchaseMatchCubit, PurchaseMatchState>(
            listener: (context, state) {
          if (state is PurchaseMatchSuccess) {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return isSelfFormGlobal
                      ? const SelfMatchDialog()
                      : const PartnerMatchDialog();
                });
          }
        }, builder: (cubitContext, state) {
          return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Image.asset(Images.logo, height: context.height / 6),
                    IconButton(
                      icon: Stack(alignment: Alignment.center, children: [
                        Image.asset(Images.buble, height: context.height / 5),
                        Column(children: [
                          Image.asset(Images.connect, height: 50),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Text('CONNECT',
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ])
                      ]),
                      onPressed: () => widget.navController.jumpToPage(2),
                    ),
                    IconButton(
                      icon: Stack(alignment: Alignment.center, children: [
                        Image.asset(Images.purpleBuble,
                            height: context.height / 5),
                        Column(children: [
                          Image.asset(Images.community, height: 50),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Text('COMMUNITY',
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ])
                      ]),
                      onPressed: () => widget.navController.jumpToPage(3),
                    ),
                    IconButton(
                        icon: Stack(alignment: Alignment.center, children: [
                          Image.asset(Images.buble, height: context.height / 5),
                          Column(children: [
                            Image.asset(Images.match, height: 50),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Text('MATCH',
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ])
                        ]),
                        onPressed: () => showMatchDialog(context))
                  ]));
        }));
  }

  void showMatchDialog(BuildContext context) async {
    bool? isSelfForm = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return const MatchFormDialog();
        });
    if (isSelfForm != null) {
      isSelfFormGlobal = isSelfForm;
      if (appUser != null && !(appUser!.buyMatch ?? false)) {
        context.read<PurchaseMatchCubit>().purchaseMatchForm();
        return;
      }
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return isSelfForm
                ? const SelfMatchDialog()
                : const PartnerMatchDialog();
          });
    }
  }
}
