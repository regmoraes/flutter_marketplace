import 'package:equatable/equatable.dart';

class Product extends Equatable {
  static const ID = "id";
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const IMAGE = "image";

  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Product({this.id, this.name, this.description, this.imageUrl});

  @override
  List<Object> get props => [id, name, description, imageUrl];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json[ID],
      name: json[NAME],
      description: json[DESCRIPTION],
      imageUrl: json[IMAGE],
    );
  }
}
