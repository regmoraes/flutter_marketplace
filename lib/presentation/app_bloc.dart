import 'dart:async';

import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/purchase.dart';

import 'states.dart';

class AppBloc {
  final OffersRepository offersRepository;
  final _offersStreamController = StreamController<OffersState>();
  final _purchaseStreamController = StreamController<PurchaseState>.broadcast();
  final _customerBalanceStreamController = StreamController<int>();

  AppBloc(this.offersRepository);

  Stream<OffersState> get offersStream => _offersStreamController.stream;

  Stream<int> get customerBalanceStream =>
      _customerBalanceStreamController.stream;

  Stream<PurchaseState> get purchaseStream => _purchaseStreamController.stream;

  void getCustomerOffers() async {
    _offersStreamController.add(OffersState(fetchingOffers: true));

    final queryResult = await offersRepository.getOffers();

    if (!queryResult.hasException) {
      final customer = Customer.fromJson(queryResult.data);
      _customerBalanceStreamController.add(customer.balance);
      _offersStreamController.add(OffersState(customer: customer));
    }
  }

  void purchaseOffer(String offerId) async {
    _purchaseStreamController.add(PurchaseState(purchasing: true));

    final queryResult = await offersRepository.purchaseOffer(offerId);

    if (!queryResult.hasException) {
      final purchase = Purchase.fromJson(queryResult.data);
      _customerBalanceStreamController.add(purchase.customerBalance);
      _purchaseStreamController.add(PurchaseState(purchase: purchase));
    }
  }

  close() {
    _offersStreamController.close();
    _purchaseStreamController.close();
    _customerBalanceStreamController.close();
  }
}
