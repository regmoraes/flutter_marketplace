import 'package:equatable/equatable.dart';
import 'package:marketplace/domain/customer.dart';
import 'package:marketplace/domain/error.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/graphql/query/mappers.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CustomerOffersPageState extends Equatable {}

class FetchingCustomerOffers extends CustomerOffersPageState {
  FetchingCustomerOffers();

  @override
  List<Object> get props => [];
}

class CustomerOffersFetched extends CustomerOffersPageState {
  final Customer customer;
  final List<Offer> offers;

  CustomerOffersFetched(this.customer, this.offers);

  @override
  List<Object> get props => [customer, offers];

  static CustomerOffersFetched createFromQueryResult(
      Map<String, dynamic> response) {
    final customer = createCustomerFromData(response[ROOT]);
    final offers = createOffersFromData(response[ROOT]);
    return CustomerOffersFetched(customer, offers);
  }
}

class FetchError extends CustomerOffersPageState {
  final Error error;

  FetchError(this.error);

  @override
  List<Object> get props => [error];
}
