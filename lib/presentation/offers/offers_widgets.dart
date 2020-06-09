import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_page.dart';
import 'package:marketplace/presentation/offers/customer_info.dart';
import 'package:marketplace/presentation/states.dart';

Widget buildOffersPage(
  Stream<OffersState> offersStream,
  Stream<int> balanceStream,
) {
  return StreamBuilder(
    stream: offersStream,
    builder: (context, snapshot) {
      if (snapshot.hasData && !snapshot.data.fetchingOffers) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomerInfo(snapshot.data.customer),
            // TODO replace for OfferList once Provider is being used
            buildOffersList(
              context,
              snapshot.data.customer.offers,
            ),
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Widget buildOffersList(BuildContext context, List<Offer> offers) {
  var size = MediaQuery
      .of(context)
      .size;
  final double itemHeight = (size.height - 200) / 2;
  final double itemWidth = size.width / 2;

  return Expanded(
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: itemWidth / itemHeight,
      ),
      itemCount: offers.length,
      itemBuilder: (context, index) => _buildOfferItem(context, offers[index]),
    ),
  );
}

final _offerItemTextStyle = TextStyle(
    fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold);

Widget _buildOfferItem(BuildContext context, Offer offer) {
  return GestureDetector(
    child: Card(
      clipBehavior: null,
      margin: EdgeInsets.all(8),
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
    onTap: () =>
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                OfferDetailPage(offer: offer, offersBloc: offersBloc),
          ),
        ),
  );
}
