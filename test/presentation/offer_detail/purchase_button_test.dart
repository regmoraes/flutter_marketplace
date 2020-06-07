import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/presentation/offer_detail/purchase_button.dart';
import 'package:marketplace/presentation/states.dart';

void main() {
  group('Given a Purchase that was not initiated yet', () {
    final purchaseState = PurchaseState();
    final purchaseButton = PurchaseButton(purchaseState);

    testWidgets('The purchase button should show a Purchase text',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: purchaseButton));

      expect(find.text('Purchase'), findsOneWidget);
    });

    group('Given a Purchase that was initiated', () {
      testWidgets(
          'The purchase button should hide the text and show a progress',
          (tester) async {
        final purchaseState = PurchaseState(purchasing: true);
        final purchaseButton = PurchaseButton(purchaseState);

        await tester.pumpWidget(MaterialApp(home: purchaseButton));

        expect(find.text('Purchase'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });
  });
}
