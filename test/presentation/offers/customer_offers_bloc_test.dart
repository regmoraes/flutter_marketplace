import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/error.dart';
import 'package:marketplace/presentation/offers/customer_offers_bloc.dart';
import 'package:marketplace/presentation/offers/event.dart';
import 'package:marketplace/presentation/offers/state.dart';
import 'package:mockito/mockito.dart';

class _MockOffersRepository extends Mock implements OffersRepository {}

void main() {
  OffersRepository _offersRepositoryMock;
  CustomerOffersBloc _customerOffersBloc;

  group('Given a CustomerOffersBloc', () {
    setUp(() {
      _offersRepositoryMock = _MockOffersRepository();
      _customerOffersBloc = CustomerOffersBloc(_offersRepositoryMock);
    });

    tearDown(() {
      _customerOffersBloc.close();
    });

    test('When requesting initial state it should emit FetchingCustomerOffers',
        () {
      expectLater(_customerOffersBloc.initialState, FetchingCustomerOffers());
    });

    test('When FetchCustomerOffers has network error it should emit FetchError',
        () {
      final queryResultErrorStub = QueryResult(
          exception: OperationException(clientException: NetworkException()));

      when(_offersRepositoryMock.getOffers()).thenAnswer((_) {
        return Future.value(queryResultErrorStub);
      });

      final expectedEvents = [
        FetchingCustomerOffers(),
        FetchError(Error.NETWORK_ERROR)
      ];

      expectLater(_customerOffersBloc, emitsInOrder(expectedEvents));

      _customerOffersBloc.add(FetchCustomerOffers());
    });

    test(
        'When FetchCustomerOffers is successful it should return CustomerOffersFetched event',
        () async {
      final file = File('test_resources/customer_offers.json');
      final jsonData = jsonDecode(await file.readAsString());
      final queryResult = QueryResult(data: jsonData, exception: null);

      when(_offersRepositoryMock.getOffers()).thenAnswer((_) {
        return Future.value(queryResult);
      });

      final expectedEvents = [
        FetchingCustomerOffers(),
        CustomerOffersFetched(Customer.fromJson(queryResult.data))
      ];

      expectLater(_customerOffersBloc, emitsInOrder(expectedEvents));

      _customerOffersBloc.add(FetchCustomerOffers());
    });
  });
}
