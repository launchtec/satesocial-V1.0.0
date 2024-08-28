import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/features/auth/domain/use_cases/update_buy_match_case.dart';
import 'purchase_match_state.dart';

class PurchaseMatchCubit extends Cubit<PurchaseMatchState> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final UpdateBuyMatchCase _updateBuyMatchCase;

  PurchaseMatchCubit({required UpdateBuyMatchCase updateBuyMatchCase})
      : _updateBuyMatchCase = updateBuyMatchCase,
        super(PurchaseMatchInitial());

  Future<void> purchaseMatchForm() async {
    emit(PurchaseMatchLoading());

    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      emit(const PurchaseMatchFailure('Store is unavailable.'));
      return;
    }

    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails({AppConstants.matchProductId});
    if (response.error != null || response.productDetails.isEmpty) {
      emit(const PurchaseMatchFailure('Failed to retrieve product details.'));
      return;
    }

    final ProductDetails productDetails = response.productDetails.first;
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);

    _inAppPurchase
        .buyNonConsumable(purchaseParam: purchaseParam)
        .catchError((error) {
      emit(PurchaseMatchFailure(error.toString()));
      return true;
    });

    _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    });
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.productID == AppConstants.matchProductId) {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          _inAppPurchase.completePurchase(purchaseDetails);
          _updateBuyMatchCase.call(FirebaseAuth.instance.currentUser!.uid, true);
          emit(PurchaseMatchSuccess());
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          emit(PurchaseMatchFailure(
              purchaseDetails.error?.message ?? 'Unknown error'));
        }
      }
    }
  }
}
