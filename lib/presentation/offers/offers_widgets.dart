import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/model/offer.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_page.dart';
import 'package:marketplace/presentation/states.dart';

final _customerInfoTextStyle =
TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold);

Widget buildOffersPage(Stream<OffersState> offersStream,
    Stream<int> balanceStream,) {
  return StreamBuilder(
    stream: offersStream,
    builder: (context, snapshot) {
      if (snapshot.hasData && !snapshot.data.fetchingOffers) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCustomerInfo(
              snapshot.data.customer,
              balanceStream,
            ),
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

Widget buildCustomerInfo(Customer customer, Stream<int> customerBalanceStream) {
  return StreamBuilder(
    stream: customerBalanceStream,
    builder: (context, snapshot) {
      final customerBalance =
      snapshot.hasData ? snapshot.data : customer.balance;

      return Card(
        margin: EdgeInsets.all(8),
        color: Colors.cyan,
        child: ListTile(
          title: Text("Hi, ${customer.name}", style: _customerInfoTextStyle),
          subtitle: Text("\$ $customerBalance", style: _customerInfoTextStyle,
            textAlign: TextAlign.end,),
        ),
      );
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

final _offerItemTextStyle =
TextStyle(fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold);

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
