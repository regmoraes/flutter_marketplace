import 'package:flutter/material.dart';
import 'package:marketplace/presentation/offer_detail/purchase_button.dart';
import 'package:marketplace/presentation/states.dart';

Widget buildPurchaseButton(
    Stream<PurchaseState> purchaseStream, Function() onPressed) {
  return StreamBuilder(
    stream: purchaseStream,
    builder: (context, snapshot) {
      return snapshot.hasData
          ? PurchaseButton(snapshot.data, null)
          : PurchaseButton(PurchaseState(), onPressed);
    },
  );
}
