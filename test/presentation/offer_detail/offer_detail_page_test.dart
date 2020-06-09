import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/model/purchase.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_page.dart';
import 'package:marketplace/presentation/offer_detail/purchase_button.dart';
import 'package:marketplace/presentation/states.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../image_fetch_mock.dart';
import '../../test_utils/offers_stub.dart';

class MockAppBloc extends Mock implements AppBloc {}

void main() {
  group(
    "Given an OfferDetailPage and an Offer",
    () {
      OfferDetailPage offerDetailPage;
      MockAppBloc mockAppBloc;
      StreamController<PurchaseState> purchaseStreamController;

      setUp(() async {
        HttpOverrides.global = new TestHttpOverrides();

        offerDetailPage = OfferDetailPage(offer: microverseBattery);
        mockAppBloc = MockAppBloc();

        purchaseStreamController = StreamController.broadcast();
        when(mockAppBloc.purchaseStream)
            .thenAnswer((_) => purchaseStreamController.stream);
      });

      tearDown(() {
        purchaseStreamController.close();
      });

      testWidgets(
        'It should show offer detail and a purchase button',
        (tester) async {
          await tester.pumpWidget(
            Provider<AppBloc>(
              create: (_) => mockAppBloc,
              child: MaterialApp(home: offerDetailPage),
            ),
          );

          await tester.pump();

          expect(
            find.byWidgetPredicate((widget) =>
                widget is OfferDetail && widget.offer == microverseBattery),
            findsOneWidget,
          );

          expect(find.byType(PurchaseButton), findsOneWidget);
        },
      );

      testWidgets(
        'When purchase is successful it should show alert with success message',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            Provider<AppBloc>(
              create: (_) => mockAppBloc,
              child: MaterialApp(home: offerDetailPage),
            ),
          );

          await tester.tap(find.byType(RaisedButton));

          purchaseStreamController
              .add(PurchaseState(purchase: Purchase(success: true)));

          await tester.pump();

          expect(find.text("You purchased your product"), findsOneWidget);
        },
      );

      testWidgets(
        'When purchase has error it should show alert with error message',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            Provider<AppBloc>(
              create: (_) => mockAppBloc,
              child: MaterialApp(home: offerDetailPage),
            ),
          );

          await tester.tap(find.byType(RaisedButton));

          final expectedErrorMessage = "Error";
          purchaseStreamController.add(
            PurchaseState(
                purchase: Purchase(
                    success: false, errorMessage: expectedErrorMessage)),
          );
          await tester.idle();
          await tester.pump(Duration.zero);

          expect(find.text(expectedErrorMessage), findsOneWidget);
        },
      );
    },
  );
}
