import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/model/product.dart';
import 'package:marketplace/model/purchase.dart';
import 'package:marketplace/presentation/offer_detail/event.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_bloc.dart';
import 'package:marketplace/presentation/offer_detail/state.dart';
import 'package:mockito/mockito.dart';

class _MockOffersRepository extends Mock implements OffersRepository {}

void main() {
  OffersRepository _offersRepositoryMock;
  OfferDetailBloc _offerDetailBloc;

  group('Given an Offer', () {
    Offer offer;

    setUp(() {
      offer = Offer(
          id: "1",
          price: 1000,
          product: Product(
              id: "1.1",
              name: "Some Product",
              description: "Stubbed product",
              imageUrl: "some.url")
      );

      _offersRepositoryMock = _MockOffersRepository();
      _offerDetailBloc = OfferDetailBloc(offer, _offersRepositoryMock);
    });

    tearDown(() {
      _offerDetailBloc.close();
    });

    test('When initiating an OfferDetailBloc it should emit OfferDetail', () {
      expectLater(_offerDetailBloc.initialState, OfferDetail(offer));
    });

    test(
        'When emiting PurchaseOffer is sucessful it should emit OfferPurchase with success',
            () async {
          final file = File('test_resources/purchase_successful.json');
          final jsonData = jsonDecode(await file.readAsString());
          final queryResult = QueryResult(data: jsonData, exception: null);

          when(_offersRepositoryMock.purchaseOffer(offer.id)).thenAnswer((_) {
            return Future.value(queryResult);
          });

          final expectedStates = [
            OfferDetail(offer),
            OfferPurchase(Purchase.fromJson(jsonData))
          ];

          expectLater(_offerDetailBloc, emitsInOrder(expectedStates));

          _offerDetailBloc.add(PurchaseOffer(offerId: offer.id));
        });

    test(
        'When emiting PurchaseOffer and user has no fund it should emit OfferPurchase with error',
            () async {
          final file = File('test_resources/purchase_no_funds.json');
          final jsonData = jsonDecode(await file.readAsString());
          final queryResult = QueryResult(data: jsonData, exception: null);

          when(_offersRepositoryMock.purchaseOffer(offer.id)).thenAnswer((_) {
            return Future.value(queryResult);
          });

          final expectedStates = [
            OfferDetail(offer),
            OfferPurchase(Purchase.fromJson(jsonData))
          ];

          expectLater(_offerDetailBloc, emitsInOrder(expectedStates));

          _offerDetailBloc.add(PurchaseOffer(offerId: offer.id));
        });
  });
}
