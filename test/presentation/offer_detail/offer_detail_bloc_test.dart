import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/domain/product.dart';
import 'package:marketplace/graphql/offers_repository.dart';
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
              imageUrl: "some.url"));

      _offersRepositoryMock = _MockOffersRepository();
      _offerDetailBloc = OfferDetailBloc(offer, _offersRepositoryMock);
    });

    tearDown(() {
      _offerDetailBloc.close();
    });

    test('When ShowOffer it should emit OfferDetail', () {
      expectLater(_offerDetailBloc.state, OfferDetail(offer));

      _offerDetailBloc.add(ShowOffer(offer));
    });
  });
}
