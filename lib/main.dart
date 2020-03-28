import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/graphql/client.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/presentation/offers/customer_offers_bloc.dart';
import 'package:marketplace/presentation/offers/customer_offers_page.dart';
import 'package:marketplace/presentation/offers/event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (BuildContext context) =>
          CustomerOffersBloc(OffersRepository(client.value))
            ..add(FetchCustomerOffers()),
          child: CustomerOffersPage(title: 'Marketplace'),
        ));
  }
}
