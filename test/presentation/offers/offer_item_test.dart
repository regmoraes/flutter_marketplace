import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/model/product.dart';
import 'package:marketplace/presentation/offers/offer_item.dart';

import '../../image_fetch_mock.dart';

void main() {
  group('Given an offer', () {
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

    testWidgets('It should show the name, image and price', (tester) async {
      final offerDetail = OfferItem(portalGunOffer);

      await tester.pumpWidget(MaterialApp(home: offerDetail));

      expect(find.text(portalGunOffer.product.name), findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Image &&
              (widget.image as NetworkImage).url ==
                  portalGunOffer.product.imageUrl),
          findsOneWidget);
      expect(find.text("\$ ${portalGunOffer.price}"), findsOneWidget);
    });
  });
}
