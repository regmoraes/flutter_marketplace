import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/model/product.dart';
import 'package:marketplace/presentation/offers/offer_item.dart';
import 'package:marketplace/presentation/offers/offers_list.dart';

import '../../image_fetch_mock.dart';

void main() {
  group('Given a list of offers', () {
    setUp(() {
      HttpOverrides.global = new TestHttpOverrides();
    });

    final portalGunOffer = Offer(
      id: "offer/portal-gun",
      price: 5000,
      product: Product(
          id: "product/portal-gun",
          name: "Portal Gun",
          description:
              "The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.",
          imageUrl:
              "https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310"),
    );

    final microverseBattery = Offer(
      id: "offer/microverse-battery",
      price: 5507,
      product: Product(
          id: "product/microverse-battery",
          name: "Microverse Battery",
          description:
              "The Microverse Battery contains a miniature universe with a planet inhabited by intelligent life.",
          imageUrl:
              "https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest/scale-to-width-down/310?cb=20160910010946"),
    );

    final offers = [portalGunOffer, microverseBattery];

    testWidgets('It should show the offer item for each offer', (tester) async {
      final offerDetail = OffersList(offers);

      await tester.pumpWidget(MaterialApp(home: offerDetail));

      offers.forEach((offer) {
        expect(
          find.byWidgetPredicate(
              (widget) => widget is OfferItem && widget.offer == offer),
          findsOneWidget,
        );
      });
    });
  });
}
