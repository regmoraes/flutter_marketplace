import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Product({this.id, this.name, this.description, this.imageUrl});

  @override
  List<Object> get props => [id, name, description, imageUrl];
}
