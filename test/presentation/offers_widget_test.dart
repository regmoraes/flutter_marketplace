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
import 'package:marketplace/presentation/offers/offers_widgets.dart';
import 'package:marketplace/presentation/states.dart';

import '../image_fetch_mock.dart';

void main() {
  group(
    'Given an OffersPage and a Customer',
    () {
      Customer customerStub;

      setUp(() async {
        final file = File('test_resources/customer_offers.json');
        final jsonData = jsonDecode(await file.readAsString());
        customerStub = Customer.fromJson(jsonData);

        HttpOverrides.global = new TestHttpOverrides();
      });

      testWidgets(
          'When first loading offers page info it should show loading indicator',
          (WidgetTester tester) async {
        final balanceStream = Stream<int>.empty();
        final offersStream = Stream.value(OffersState(fetchingOffers: true));

        final widget = buildOffersPage(offersStream, balanceStream);

        await tester.pumpWidget(MaterialApp(home: widget));
        await tester.idle();
        await tester.pump(Duration.zero);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets(
          'When building customer info it should show the name and balance',
          (WidgetTester tester) async {
        final balanceStream = Stream<int>.empty();
        final widget = buildCustomerInfo(customerStub, balanceStream);

        await tester.pumpWidget(MaterialApp(home: widget));
        await tester.idle();
        await tester.pump(Duration.zero);

        expect(find.text('Hi, ${customerStub.name}'), findsOneWidget);
        expect(find.text('\$ ${customerStub.balance}'), findsOneWidget);
      });

      testWidgets('When balance updates it should change the balance',
          (WidgetTester tester) async {
        final balanceStreamController = StreamController<int>();

        final widget =
            buildCustomerInfo(customerStub, balanceStreamController.stream);

        await tester.pumpWidget(MaterialApp(home: widget));
        await tester.idle();
        await tester.pump(Duration.zero);

        expect(find.text('Hi, ${customerStub.name}'), findsOneWidget);
        expect(find.text('\$ ${customerStub.balance}'), findsOneWidget);

        final newBalance = 300;
        balanceStreamController.add(newBalance);

        await tester.idle();
        await tester.pump(Duration.zero);

        expect(find.text('\$ $newBalance'), findsOneWidget);
        expect(find.text('\$ ${customerStub.balance}'), findsNothing);

        balanceStreamController.close();
      });

      testWidgets(
          'When building offers info it should show name, price and image',
          (WidgetTester tester) async {
        final offersStream = Stream.value(OffersState(customer: customerStub));
        final balanceStream = Stream<int>.empty();
        final widget = buildOffersPage(offersStream, balanceStream);

        await tester.pumpWidget(MaterialApp(home: widget));
        await tester.idle();
        await tester.pump(Duration.zero);

        customerStub.offers.forEach(
          (offer) {
            expect(find.text('${offer.product.name}'), findsOneWidget);
            expect(find.text('\$ ${offer.price}'), findsOneWidget);
          },
        );
        expect(find.byType(Image), findsNWidgets(customerStub.offers.length));
      });
    },
  );
}
