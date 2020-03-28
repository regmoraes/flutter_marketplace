import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_page.dart';

Widget buildOfferList(BuildContext context, List<Offer> offers) {
  return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) => _buildOfferItem(context, offers[index]));
}

Widget _buildOfferItem(BuildContext context, Offer offer) {
  return GestureDetector(
    child: Container(
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
    ),
    onTap: () =>
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => OfferDetailPage(offer: offer),
          ),
    ),
  );
}
