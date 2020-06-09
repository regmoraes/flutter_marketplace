import 'package:flutter/material.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offers/offers_list.dart';
import 'package:marketplace/presentation/states.dart';
import 'package:provider/provider.dart';

import 'customer_info.dart';

class CustomerOffersPage extends StatefulWidget {
  final String title;

  CustomerOffersPage({Key key, this.title = 'Marketplace'}) : super(key: key);

  @override
  _CustomerOffersPageState createState() => _CustomerOffersPageState();
}

class _CustomerOffersPageState extends State<CustomerOffersPage> {
  AppBloc appBloc;

  @override
  void initState() {
    super.initState();
    appBloc = Provider.of<AppBloc>(context, listen: false);
    appBloc.getCustomerOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 4,
      ),
      body: Container(
        child: StreamBuilder(
          stream: appBloc.offersStream,
          builder: (context, AsyncSnapshot<OffersState> snapshot) {
            if (snapshot.hasData && !snapshot.data.fetchingOffers) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomerInfo(snapshot.data.customer),
                  Expanded(child: OffersList(snapshot.data.customer.offers))
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    appBloc.close();
  }
}
