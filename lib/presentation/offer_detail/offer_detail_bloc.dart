import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/graphql/offers_repository.dart';

import 'event.dart';
import 'state.dart';

class OfferDetailBloc extends Bloc<OfferDetailEvent, OfferDetailState> {
  final Offer offer;
  final OffersRepository offersRepository;

  OfferDetailBloc(this.offer, this.offersRepository);

  @override
  OfferDetailState get initialState => OfferDetail(offer);

  @override
  Stream<OfferDetailState> mapEventToState(OfferDetailEvent event) async* {
    if (event is ShowOffer) {
      yield OfferDetail(offer);
    } else if (event is PurchaseOffer) {
      final purchaseResult = await offersRepository.purchaseOffer(
          event.offerId);

      if (!purchaseResult.hasException) {
        final offerPurchased = OfferPurchase.createOfferPurchaseFromData(
            purchaseResult.data);

        if (offerPurchased.success != null) {
          yield offerPurchased;
        }
      }
    }
  }
}
