import 'package:equatable/equatable.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/domain/purchase.dart';
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

  final Purchase purchase;

  OfferPurchase(this.purchase);

  @override
  List<Object> get props => [purchase];
}
