import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/error.dart';

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
        final customer = Customer.fromJson(queryResult.data);
        yield CustomerOffersFetched(customer);

      } else {
        yield FetchError(Error.NETWORK_ERROR);
      }
    }
  }
}
