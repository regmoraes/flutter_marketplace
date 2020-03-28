import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/model/purchase.dart';

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
        final purchase = Purchase.fromJson(purchaseResult.data);

        if (purchase.success != null) {
          yield OfferPurchase(purchase);
        }
      }
    }
  }
}
