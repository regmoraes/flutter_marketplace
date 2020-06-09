import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_page.dart';

class OfferItem extends StatelessWidget {
  final Offer offer;

  OfferItem(this.offer);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: null,
        margin: const EdgeInsets.all(8),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                child: Text(
              "${offer.product.name}",
              textAlign: TextAlign.center,
              style: _offerItemTextStyle,
            )),
            Image.network(
              offer.product.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
                child: Text(
              "\$ ${offer.price}",
              textAlign: TextAlign.center,
              style: _offerItemTextStyle,
            )),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfferDetailPage(offer: offer),
        ),
      ),
    );
  }
}

const _offerItemTextStyle = TextStyle(
    fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold);
