import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/presentation/offers_widgets.dart';

class CustomerOffersPage extends StatefulWidget {
  final String title;

  CustomerOffersPage({Key key, this.title}) : super(key: key);

  @override
  _CustomerOffersPageState createState() => _CustomerOffersPageState();
}

class _CustomerOffersPageState extends State<CustomerOffersPage> {
  @override
  void initState() {
    super.initState();
    offersBloc.getCustomerOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: offersBloc.customerBalanceStream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Text("The balance is ${snapshot.data}")
                    : CircularProgressIndicator();
              },
            ),
            StreamBuilder(
              stream: offersBloc.offersStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.data.fetchingOffers) {
                  return Expanded(
                      child: buildOfferList(
                          context, snapshot.data.customer.offers));
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    offersBloc.close();
  }
}
