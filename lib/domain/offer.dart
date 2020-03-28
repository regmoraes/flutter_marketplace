import 'package:equatable/equatable.dart';

import 'product.dart';

class Offer extends Equatable {
  final String id;
  final num price;
  final Product product;

  Offer({this.id, this.price, this.product});

  @override
  List<Object> get props => [id, price, product];  
}
