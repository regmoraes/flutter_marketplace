import 'package:marketplace/domain/product.dart';

class Offer {
  String id;
  num price;
  Product product;

  Offer({this.id, this.price, this.product});
}
