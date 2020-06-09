import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/model/offer.dart';

class OfferDetail extends StatelessWidget {
  final Offer offer;

  OfferDetail(this.offer);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Image.network(
              offer.product.imageUrl,
              key: Key("${offer.id}"),
              fit: BoxFit.contain,
            ),
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
    );
  }
}

const _offerDetailTextStyle =
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
