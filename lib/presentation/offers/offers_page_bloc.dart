import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/graphql/offers_repository.dart';

import 'offers_page_event.dart';
import 'offers_page_state.dart';

class OffersBloc extends Bloc<OffersPageEvent, OffersPageState> {
  OffersRepository offersRepository;

  OffersBloc(this.offersRepository);

  @override
  OffersPageState get initialState => FetchingCustomerOffers();

  @override
  Stream<OffersPageState> mapEventToState(OffersPageEvent event) async* {
    //TODO
  }
}
