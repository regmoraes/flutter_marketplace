import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/domain/offer.dart';

Widget buildOfferList(BuildContext context, List<Offer> offers) {
  return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) => _buildOfferItem(context, offers[index]));
}

Widget _buildOfferItem(BuildContext context, Offer offer) {
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
