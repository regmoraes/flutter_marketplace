import 'package:equatable/equatable.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/error.dart';
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

  CustomerOffersFetched(this.customer);

  @override
  List<Object> get props => [customer];
}

class FetchError extends CustomerOffersPageState {
  final Error error;

  FetchError(this.error);

  @override
  List<Object> get props => [error];
}
