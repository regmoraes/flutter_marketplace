import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final num balance;

  Customer({this.id, this.name, this.balance});

  @override
  List<Object> get props => [id, name, balance];

}
