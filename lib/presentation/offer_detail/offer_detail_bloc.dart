import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/offer.dart';
import '../../graphql/offers_repository.dart';
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
    }
  }
}
