import 'package:flutter/material.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offers/offers_widgets.dart';
import 'package:provider/provider.dart';

class CustomerOffersPage extends StatefulWidget {
  final String title;

  CustomerOffersPage({Key key, this.title}) : super(key: key);

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
        child: buildOffersPage(
          appBloc.offersStream,
          appBloc.customerBalanceStream,
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
