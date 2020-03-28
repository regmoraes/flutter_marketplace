import 'package:equatable/equatable.dart';

import 'product.dart';

class Offer extends Equatable {
  static const ID = "id";
  static const PRICE = "price";
  static const PRODUCT = "product";

  final String id;
  final num price;
  final Product product;

  Offer({this.id, this.price, this.product});

  @override
  List<Object> get props => [id, price, product];

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json[ID],
      price: json[PRICE],
      product: Product.fromJson(json[PRODUCT]),
    );
  }
}
