import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/presentation/offers/state.dart';
import 'package:marketplace/presentation/offers/widget.dart';

import 'customer_offers_bloc.dart';

class CustomerOffersPage extends StatefulWidget {
  CustomerOffersPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomerOffersPageState createState() => _CustomerOffersPageState();
}

class _CustomerOffersPageState extends State<CustomerOffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<CustomerOffersBloc>(context),
        builder: (context, state) {
          if (state is FetchingCustomerOffers)
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );

          if (state is CustomerOffersFetched)
            return Container(
              child: Column(
                children: <Widget>[
                  Text("Customer: ${state.customer.name}"),
                  Expanded(child:
                  buildOfferList(context, state.customer.offers),
                  ),
                ],
              ),
            );

          return Text('There was an error!');
        },
      ),
    );
  }
}
