import 'package:flutter/material.dart';

import '../../domain/offer.dart';

Widget buildOfferDetail(BuildContext context, Offer offer) {
  return Container(
    color: Colors.teal,
    child: Column(
      children: <Widget>[
        Text("${offer.id}"),
        Text("${offer.price}"),
        Text("${offer.product.id}"),
        Text("${offer.product.name}"),
        Text("${offer.product.description}"),
        Image.network(offer.product.imageUrl),
      ],
    ),
  );
}
