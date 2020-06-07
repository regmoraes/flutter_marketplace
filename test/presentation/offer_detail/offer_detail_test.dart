import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/model/product.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail.dart';

import '../../image_fetch_mock.dart';

void main() {
  group('Given an offer', () {
    setUp(() {
      HttpOverrides.global = new TestHttpOverrides();
    });

    final offer = Offer(
        id: "offer-id",
        price: 5000,
        product: Product(
            id: "product-id",
            name: "test product",
            description: "used for testing",
            imageUrl: "imageUrl"));

    testWidgets('It should show the description, image and price',
        (tester) async {
      final offerDetail = OfferDetail(offer);

      await tester.pumpWidget(MaterialApp(home: offerDetail));

      expect(find.text(offer.product.description), findsOneWidget);
      expect(find.text("Price: \$${offer.price}"), findsOneWidget);

      expect(find.byKey(Key("${offer.id}")), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
