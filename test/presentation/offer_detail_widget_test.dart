// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/model/purchase.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_page.dart';
import 'package:marketplace/presentation/states.dart';
import 'package:mockito/mockito.dart';

import '../image_fetch_mock.dart';

class MockAppBloc extends Mock implements AppBloc {}

void main() {
  group(
    "Given an OfferDetail page and an Offer",
    () {
      Offer offerStub;
      MockAppBloc mockAppBloc;

      setUp(() async {
        final file = File('test_resources/customer_offers.json');
        final jsonData = jsonDecode(await file.readAsString());
        offerStub = Customer.fromJson(jsonData).offers.first;

        mockAppBloc = MockAppBloc();

        HttpOverrides.global = new TestHttpOverrides();
      });

      testWidgets(
          'When first loading page it should show offer name, description, price and a purchase button',
          (WidgetTester tester) async {
        final purchaseStreamController =
            StreamController<PurchaseState>.broadcast();
        when(mockAppBloc.purchaseStream)
            .thenAnswer((_) => purchaseStreamController.stream);

        final widget =
        OfferDetailPage(offer: offerStub, offersBloc: mockAppBloc);
        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.text('${offerStub.product.name}'), findsOneWidget);
        expect(find.text('${offerStub.product.description}'), findsOneWidget);
        expect(find.text('Price: \$${offerStub.price}'), findsOneWidget);
        expect(find.widgetWithText(RaisedButton, "Purchase"), findsOneWidget);

        purchaseStreamController.close();
      });

      testWidgets(
          'When purchase is successful it should show alert with success message',
          (WidgetTester tester) async {
        final purchaseStreamController =
            StreamController<PurchaseState>.broadcast();
        when(mockAppBloc.purchaseStream)
            .thenAnswer((_) => purchaseStreamController.stream);

        final widget = OfferDetailPage(
          offer: offerStub,
          offersBloc: mockAppBloc,
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        await tester.tap(find.byType(RaisedButton));

        purchaseStreamController
            .add(PurchaseState(purchase: Purchase(success: true)));
        await tester.idle();
        await tester.pump(Duration.zero);

        expect(find.text("You purchased your product"), findsOneWidget);

        purchaseStreamController.close();
      });

      testWidgets(
          'When purchase has error it should show alert with error message',
          (WidgetTester tester) async {
        final purchaseStreamController =
            StreamController<PurchaseState>.broadcast();
        when(mockAppBloc.purchaseStream)
            .thenAnswer((_) => purchaseStreamController.stream);

        final widget = OfferDetailPage(
          offer: offerStub,
          offersBloc: mockAppBloc,
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        await tester.tap(find.byType(RaisedButton));

        final expectedErrorMessage = "Error";
        purchaseStreamController.add(
          PurchaseState(
              purchase:
                  Purchase(success: false, errorMessage: expectedErrorMessage)),
        );
        await tester.idle();
        await tester.pump(Duration.zero);

        expect(find.text(expectedErrorMessage), findsOneWidget);

        purchaseStreamController.close();
      });
    },
  );
}
