import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/domain/error.dart';
import 'package:marketplace/graphql/offers_repository.dart';

import 'event.dart';
import 'state.dart';

class CustomerOffersBloc
    extends Bloc<CustomerOffersPageEvent, CustomerOffersPageState> {

  OffersRepository offersRepository;

  CustomerOffersBloc(this.offersRepository);

  @override
  CustomerOffersPageState get initialState => FetchingCustomerOffers();

  @override
  Stream<CustomerOffersPageState> mapEventToState(
      CustomerOffersPageEvent event) async* {
    if (event is FetchCustomerOffers) {
      final queryResult = await offersRepository.getOffers();

      if (!queryResult.hasException) {
        yield CustomerOffersFetched.createFromQueryResult(queryResult.data);
      } else {
        yield FetchError(Error.NETWORK_ERROR);
      }
    }
  }
}
