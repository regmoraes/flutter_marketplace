// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/presentation/offers/offers_widgets.dart';
import 'package:marketplace/presentation/states.dart';

import '../image_fetch_mock.dart';

void main() {
  group(
    'Given an OffersPage and a Customer',
    () {
      setUp(() async {
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
    },
  );
}
