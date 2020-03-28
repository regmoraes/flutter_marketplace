import 'package:equatable/equatable.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/graphql/mutation/mappers.dart';
import 'package:marketplace/graphql/query/mappers.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OfferDetailState extends Equatable {}

class OfferDetail extends OfferDetailState {
  final Offer offer;

  OfferDetail(this.offer);

  @override
  List<Object> get props => [offer];
}

class OfferPurchase extends OfferDetailState {

  final bool success;
  final String errorMessage;
  final int customerBalance;

  OfferPurchase(this.success, this.errorMessage, this.customerBalance);

  static OfferPurchase createOfferPurchaseFromData(
      Map<String, dynamic> responseRoot) {
    return OfferPurchase(
        responseRoot[PURCHASE][PURCHASE_SUCCESS],
        responseRoot[PURCHASE][PURCHASE_ERROR_MESSAGE],
        responseRoot[PURCHASE][CUSTOMER][CUSTOMER_BALANCE]
    );
  }

  @override
  List<Object> get props => [success, errorMessage, customerBalance];
}
