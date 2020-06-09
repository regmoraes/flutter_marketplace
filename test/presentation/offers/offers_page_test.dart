import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offers/customer_info.dart';
import 'package:marketplace/presentation/offers/offers_list.dart';
import 'package:marketplace/presentation/offers/offers_page.dart';
import 'package:marketplace/presentation/states.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../image_fetch_mock.dart';
import '../../test_utils/customer_stub.dart';
import '../../test_utils/mock_app_bloc.dart';

void main() {
  group(
    'Given a CustomerOffersPage and a Customer',
    () {
      CustomerOffersPage customerOffersPage;
      MockAppBloc mockAppBloc;
      StreamController<OffersState> offersStreamController;

      setUp(() async {
        HttpOverrides.global = new TestHttpOverrides();
        customerOffersPage = CustomerOffersPage();
        mockAppBloc = MockAppBloc();
        offersStreamController = StreamController();
      });

      tearDown(() {
        offersStreamController.close();
      });

      testWidgets('It should show a loading indicator while fetching offers',
          (tester) async {
        when(mockAppBloc.offersStream)
            .thenAnswer((_) => offersStreamController.stream);

        await tester.pumpWidget(
          Provider<AppBloc>(
            create: (_) => mockAppBloc,
            child: MaterialApp(home: customerOffersPage),
          ),
        );

        offersStreamController.add(OffersState(fetchingOffers: true));

        await tester.pump();

        verify(mockAppBloc.getCustomerOffers());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        expect(find.byType(OffersList), findsNothing);
        expect(find.byType(CustomerInfo), findsNothing);
      });

      testWidgets(
          'It should show customer info and a list of offers after successful fetching',
          (tester) async {
        when(mockAppBloc.offersStream)
            .thenAnswer((_) => offersStreamController.stream);

        await tester.pumpWidget(
          Provider<AppBloc>(
            create: (_) => mockAppBloc,
            child: MaterialApp(home: customerOffersPage),
          ),
        );

        offersStreamController.add(OffersState(customer: customerStub));

        await tester.pump();

        expect(
            find.byWidgetPredicate((widget) =>
                widget is CustomerInfo && widget.customer == customerStub),
            findsOneWidget);

        expect(
            find.byWidgetPredicate((widget) =>
                widget is OffersList && widget.offers == customerStub.offers),
            findsOneWidget);
      });
    },
  );
}
