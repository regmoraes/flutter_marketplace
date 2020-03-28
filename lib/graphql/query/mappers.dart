import 'package:marketplace/domain/customer.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/domain/product.dart';

const ROOT = "viewer";

const CUSTOMER = "customer";
const CUSTOMER_ID = "id";
const CUSTOMER_NAME = "name";
const CUSTOMER_BALANCE = "balance";
const CUSTOMER_OFFERS = "offers";

const OFFER_DESCRIPTION = "description";
const OFFER_ID = "id";
const OFFER_IMAGE = "image";
const OFFER_NAME = "name";
const OFFER_PRICE = "price";
const OFFER_PRODUCT = "product";

const PRODUCT_ID = "id";
const PRODUCT_NAME = "name";
const PRODUCT_DESCRIPTION = "description";
const PRODUCT_IMAGE = "image";

Customer createCustomerFromData(Map<String, dynamic> responseRoot) {
  return Customer(
      id: responseRoot[CUSTOMER_ID],
      name: responseRoot[CUSTOMER_NAME],
      balance: responseRoot[CUSTOMER_BALANCE]);
}

List<Offer> createOffersFromData(Map<String, dynamic> responseRoot) {
  List offersData = responseRoot[CUSTOMER_OFFERS];
  return offersData.map((offerData) {
    Product product = _createProductFromData(offerData[OFFER_PRODUCT]);
    return Offer(
        id: offerData[OFFER_ID],
        price: offerData[OFFER_PRICE],
        product: product);
  }).toList();
}

Product _createProductFromData(Map<String, dynamic> response) {
  return Product(
      id: response[PRODUCT_ID],
      name: response[PRODUCT_NAME],
      description: response[PRODUCT_DESCRIPTION],
      imageUrl: response[PRODUCT_IMAGE]);
}
