import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'purchase_post_state.dart';

class PurchasePostCubit extends Cubit<PurchasePostState> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  PurchasePostCubit() : super(PurchasePostInitial());

  Future<void> purchaseGigPost() async {
    emit(PurchasePostLoading());

    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      emit(const PurchasePostFailure('Store is unavailable.'));
      return;
    }

    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails({AppConstants.gigProductId});
    if (response.error != null || response.productDetails.isEmpty) {
      emit(const PurchasePostFailure('Failed to retrieve product details.'));
      return;
    }

    final ProductDetails productDetails = response.productDetails.first;
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

    _inAppPurchase.buyConsumable(purchaseParam: purchaseParam).catchError((error) {
      emit(PurchasePostFailure(error.toString()));
      return true;
    });

    _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    });
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    if (purchaseDetailsList.first.productID.isEmpty) {
      emit(const PurchasePostFailure('Failed to retrieve product details.'));
      return;
    }
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.productID == AppConstants.gigProductId) {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          _inAppPurchase.completePurchase(purchaseDetails);
          emit(PurchasePostSuccess());
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          emit(PurchasePostFailure(purchaseDetails.error?.message ?? 'Unknown error'));
        }
      }
    }
  }
}