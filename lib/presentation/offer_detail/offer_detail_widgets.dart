import 'package:flutter/material.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/presentation/offer_detail/purchase_button.dart';
import 'package:marketplace/presentation/states.dart';

final _offerDetailTextStyle =
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);

Widget buildOfferDetail(BuildContext context, Offer offer) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(
            offer.product.imageUrl,
            fit: BoxFit.contain,
          ),
          Text(
            "${offer.product.description}",
            textAlign: TextAlign.start,
            style: _offerDetailTextStyle,
          ),
          Text(
            "Price: \$${offer.price}",
            textAlign: TextAlign.right,
            style: _offerDetailTextStyle,
          ),
        ],
      ),
    ),
  );
}

Widget buildPurchaseButton(Stream<PurchaseState> purchaseStream,
    Function() onPressed) {
  return StreamBuilder(
    stream: purchaseStream,
    builder: (context, snapshot) {
      return snapshot.hasData
          ? PurchaseButton(snapshot.data, null)
          : PurchaseButton(PurchaseState(), onPressed);
    },
  );
}
