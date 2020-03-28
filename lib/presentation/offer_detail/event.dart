import 'package:equatable/equatable.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OfferDetailEvent extends Equatable {}

class ShowOffer extends OfferDetailEvent {
  final Offer offer;

  ShowOffer(this.offer);

  @override
  List<Object> get props => [offer];
}

class PurchaseOffer extends OfferDetailEvent {
  final String offerId;

  PurchaseOffer({this.offerId});

  @override
  List<Object> get props => [offerId];
}
