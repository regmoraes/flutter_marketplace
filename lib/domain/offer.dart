import 'package:marketplace/domain/product.dart';

class Offer {
  String id;
  String name;
  num price;
  Product product;

  Offer(this.id, this.name, this.price, this.product);
}
