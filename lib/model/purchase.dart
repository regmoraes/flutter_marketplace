import 'package:equatable/equatable.dart';
import 'package:marketplace/model/customer.dart';

class Purchase extends Equatable {
  static const PURCHASE = "purchase";
  static const OFFER_ID = "offerId";
  static const SUCCESS = "success";
  static const ERROR_MESSAGE = "errorMessage";

  final bool success;
  final String errorMessage;
  final int customerBalance;

  Purchase({this.success, this.errorMessage, this.customerBalance});

  @override
  List<Object> get props => [success, errorMessage, customerBalance];

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      success: json[PURCHASE][SUCCESS],
      errorMessage: json[PURCHASE][ERROR_MESSAGE],
      customerBalance: json[PURCHASE][Customer.CUSTOMER][Customer.BALANCE],
    );
  }
}
