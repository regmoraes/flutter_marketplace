import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/graphql/client.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/presentation/offer_detail/event.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_bloc.dart';
import 'package:marketplace/presentation/offer_detail/state.dart';
import 'package:marketplace/presentation/offer_detail/widget.dart';

class OfferDetailPage extends StatelessWidget {
  final Offer offer;

  const OfferDetailPage({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offerDetailBloc = OfferDetailBloc(
        offer, OffersRepository(client.value));

    return Scaffold(
      appBar: AppBar(
        title: Text(offer.product.name),
      ),
      body: Container(
        color: Colors.teal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: BlocBuilder(
                bloc: offerDetailBloc,
                builder: (context, state) {
                  if (state is OfferDetail)
                    return buildOfferDetail(context, state.offer);

                  if (state is OfferPurchase) {
                    if (state.purchase.success)
                      return Text(
                          "Great Purchase! Now yo u have ${state.purchase
                              .customerBalance}");
                    else
                      return Text("Oh no! ${state.purchase.errorMessage}");
                  }
                  return Text('There was an error!');
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(64),
              child: RaisedButton(
                onPressed: () =>
                    offerDetailBloc.add(PurchaseOffer(offerId: offer.id)),
                child: Text("Purchase"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
