import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offers/customer_info.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../test_utils/mock_app_bloc.dart';

void main() {
  group('Given a customer', () {
    AppBloc mockAppBloc;

    final customer = Customer(
      id: "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
      name: "Jerry Smith",
      balance: 1000000,
      offers: [],
    );

    setUp(() {
      mockAppBloc = MockAppBloc();
    });

    testWidgets('It should show the name and balance first', (tester) async {
      await tester.pumpWidget(
        Provider<AppBloc>(
          create: (context) => mockAppBloc,
          child: MaterialApp(home: CustomerInfo(customer)),
        ),
      );

      expect(find.text('Hi, ${customer.name}'), findsOneWidget);
      expect(find.text('\$ ${customer.balance}'), findsOneWidget);
    });

    testWidgets('It should update the balance after receiving updates',
        (tester) async {
      final newBalance = 4500;
      final balanceStreamController = StreamController<int>.broadcast();
      final balanceStream = balanceStreamController.stream;

      when(mockAppBloc.customerBalanceStream).thenAnswer((_) => balanceStream);

      await tester.pumpWidget(
        Provider<AppBloc>(
          create: (context) => mockAppBloc,
          child: MaterialApp(home: CustomerInfo(customer)),
        ),
      );

      expect(find.text('\$ ${customer.balance}'), findsOneWidget);

      balanceStreamController.add(newBalance);
      await tester.pump();

      expect(find.text('\$ $newBalance'), findsOneWidget);

      await balanceStreamController.close();
    });
  });
}
