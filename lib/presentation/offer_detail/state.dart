import 'package:equatable/equatable.dart';

import '../../domain/offer.dart';

abstract class OfferDetailState extends Equatable {}

class OfferDetail extends OfferDetailState {
  final Offer offer;

  OfferDetail(this.offer);

  @override
  List<Object> get props => [offer];
}
