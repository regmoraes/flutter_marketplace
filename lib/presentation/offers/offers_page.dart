import 'package:flutter/material.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offers/offers_widgets.dart';

class CustomerOffersPage extends StatefulWidget {
  final String title;
  final AppBloc offersBloc;

  CustomerOffersPage({Key key, this.title, this.offersBloc}) : super(key: key);

  @override
  _CustomerOffersPageState createState() => _CustomerOffersPageState();
}

class _CustomerOffersPageState extends State<CustomerOffersPage> {
  @override
  void initState() {
    super.initState();
    widget.offersBloc.getCustomerOffers();
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
          widget.offersBloc.offersStream,
          widget.offersBloc.customerBalanceStream,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.offersBloc.close();
  }
}
