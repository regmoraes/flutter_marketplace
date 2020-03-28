import 'package:equatable/equatable.dart';
import 'package:marketplace/domain/offer.dart';

class Customer extends Equatable {
  static const VIEWER = "viewer";
  static const CUSTOMER = "customer";
  static const ID = "id";
  static const NAME = "name";
  static const BALANCE = "balance";
  static const OFFERS = "offers";

  final String id;
  final String name;
  final num balance;
  final List<Offer> offers;

  Customer({this.id, this.name, this.balance, this.offers});

  @override
  List<Object> get props => [id, name, balance];

  factory Customer.fromJson(Map<String, dynamic> json) {
    List<Offer> offers = (json[VIEWER][OFFERS] as List)
        .map((jsonOffer) => Offer.fromJson(jsonOffer))
        .toList();

    return Customer(
        id: json[VIEWER][ID],
        name: json[VIEWER][NAME],
        balance: json[VIEWER][BALANCE],
        offers: offers);
  }
}
