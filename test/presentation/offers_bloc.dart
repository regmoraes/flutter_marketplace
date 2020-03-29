import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/purchase.dart';
import 'package:marketplace/presentation/offers_bloc.dart';
import 'package:marketplace/presentation/offers_state.dart';
import 'package:mockito/mockito.dart';

class _MockOffersRepository extends Mock implements OffersRepository {}

void main() {
  OffersRepository _offersRepositoryMock;
  OffersBloc _offersBloc;

  group('Given a OffersBloc', () {
    setUp(() {
      _offersRepositoryMock = _MockOffersRepository();
      _offersBloc = OffersBloc(_offersRepositoryMock);
    });

    tearDown(() {
      _offersBloc.close();
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

      expectLater(_offersBloc.offersStream, emitsInOrder(expectedEvents));

      _offersBloc.getCustomerOffers();
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
          _offersBloc.purchaseStream, emitsInOrder(expectedPurchaseStates));
      expectLater(
          _offersBloc.customerBalanceStream, emits(expectedCustomerBalance));

      _offersBloc.purchaseOffer("some_id");
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

      expectLater(_offersBloc.purchaseStream, emitsInOrder(expectedEvents));

      _offersBloc.purchaseOffer("some_id");

      expect(expectedEvents[1].purchase.errorMessage, isNotNull);
    });
  });
}
