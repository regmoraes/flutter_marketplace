import 'package:equatable/equatable.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/purchase.dart';

class OffersState extends Equatable {
  final bool fetchingOffers;
  final Customer customer;
  final String errorMessage;

  OffersState({this.fetchingOffers = false, this.customer, this.errorMessage});

  @override
  List<Object> get props => [fetchingOffers, customer, errorMessage];
}

class PurchaseState extends Equatable {
  final bool purchasing;
  final Purchase purchase;

  PurchaseState({this.purchasing = false, this.purchase});

  @override
  List<Object> get props => [purchasing, purchase];
}
