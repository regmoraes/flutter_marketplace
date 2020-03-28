import 'package:equatable/equatable.dart';

import '../../domain/offer.dart';

abstract class OfferDetailEvent extends Equatable {}

class ShowOffer extends OfferDetailEvent {
  final Offer offer;

  ShowOffer(this.offer);

  @override
  List<Object> get props => [offer];
}

class PurchaseOffer extends OfferDetailEvent {
  final int offerId;

  PurchaseOffer(this.offerId);

  @override
  List<Object> get props => [offerId];
}
