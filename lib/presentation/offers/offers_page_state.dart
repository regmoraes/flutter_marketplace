import 'package:marketplace/domain/customer.dart';
import 'package:marketplace/domain/offer.dart';

abstract class OffersPageState {}

class FetchingCustomerOffers implements OffersPageState {
  FetchingCustomerOffers();
}

class CustomerOffersFetched implements OffersPageState {
  Customer customer;
  List<Offer> offers;

  CustomerOffersFetched(this.customer, this.offers);
}

class FetchError implements OffersPageState {
  Error error;

  FetchError(this.error);
}
