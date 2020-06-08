import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/presentation/offers/offer_item.dart';

class OffersList extends StatelessWidget {
  final List<Offer> offers;

  OffersList(this.offers);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 100) / 2;
    final double itemWidth = size.width / 2;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: itemWidth / itemHeight,
      ),
      itemCount: offers.length,
      itemBuilder: (context, index) => OfferItem(offers[index]),
    );
  }
}
