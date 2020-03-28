import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/domain/offer.dart';
import 'package:marketplace/graphql/client.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/presentation/offer_detail/offer_detail_bloc.dart';
import 'package:marketplace/presentation/offer_detail/state.dart';
import 'package:marketplace/presentation/offer_detail/widget.dart';

class OfferDetailPage extends StatelessWidget {
  final Offer offer;

  const OfferDetailPage({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.product.name),
      ),
      body: BlocBuilder(
        bloc: OfferDetailBloc(
          offer,
          OffersRepository(client.value),
        ),
        builder: (context, state) {
          if (state is OfferDetail)
            return buildOfferDetail(context, state.offer);
          return Text('There was an error!');
        },
      ),
    );
  }
}
