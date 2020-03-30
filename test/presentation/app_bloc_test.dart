import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/purchase.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/states.dart';
import 'package:mockito/mockito.dart';

class _MockOffersRepository extends Mock implements OffersRepository {}

void main() {
  OffersRepository _offersRepositoryMock;
  AppBloc _appBloc;

  group('Given an AppBloc', () {
    setUp(() {
      _offersRepositoryMock = _MockOffersRepository();
      _appBloc = AppBloc(_offersRepositoryMock);
    });

    tearDown(() {
      _appBloc.close();
    });

    test('When getOffers is successful it should emit offers state', () async {
      final file = File('test_resources/customer_offers.json');
      final jsonData = jsonDecode(await file.readAsString());
      final queryResult = QueryResult(data: jsonData, exception: null);
      final expectedCustomer = Customer.fromJson(queryResult.data);

      when(_offersRepositoryMock.getOffers()).thenAnswer((_) {
        return Future.value(queryResult);
      });

      final expectedEvents = [
        OffersState(fetchingOffers: true),
        OffersState(customer: expectedCustomer)
      ];

      expectLater(_appBloc.offersStream, emitsInOrder(expectedEvents));

      _appBloc.getCustomerOffers();
    });

    test(
        'When purchaseOffer is sucessful it should emit purchase state and update customer balance',
        () async {
      final file = File('test_resources/purchase_successful.json');
      final jsonData = jsonDecode(await file.readAsString());
      final queryResult = QueryResult(data: jsonData, exception: null);
      final expectedPurchase = Purchase.fromJson(queryResult.data);

      when(_offersRepositoryMock.purchaseOffer(any)).thenAnswer((_) {
        return Future.value(queryResult);
      });

      final expectedPurchaseStates = [
        PurchaseState(purchasing: true),
        PurchaseState(purchase: expectedPurchase)
      ];
      final expectedCustomerBalance = expectedPurchase.customerBalance;

      expectLater(
          _appBloc.purchaseStream, emitsInOrder(expectedPurchaseStates));
      expectLater(
          _appBloc.customerBalanceStream, emits(expectedCustomerBalance));

      _appBloc.purchaseOffer("some_id");
    });

    test(
        'When purchaseOffer has error it should emit purchase state with error',
        () async {
      final file = File('test_resources/purchase_no_funds.json');
      final jsonData = jsonDecode(await file.readAsString());
      final queryResult = QueryResult(data: jsonData, exception: null);
      final expectedPurchase = Purchase.fromJson(queryResult.data);

      when(_offersRepositoryMock.purchaseOffer(any)).thenAnswer((_) {
        return Future.value(queryResult);
      });

      final expectedEvents = [
        PurchaseState(purchasing: true),
        PurchaseState(purchase: expectedPurchase)
      ];

      expectLater(_appBloc.purchaseStream, emitsInOrder(expectedEvents));

      _appBloc.purchaseOffer("some_id");

      expect(expectedEvents[1].purchase.errorMessage, isNotNull);
    });
  });
}
