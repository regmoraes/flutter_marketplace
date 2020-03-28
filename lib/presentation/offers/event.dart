import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CustomerOffersPageEvent extends Equatable {
  CustomerOffersPageEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomerOffers extends CustomerOffersPageEvent {
  FetchCustomerOffers();

  @override
  List<Object> get props => [];
}
