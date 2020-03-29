import 'package:flutter/material.dart';
import 'package:marketplace/graphql/client.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/presentation/offers_bloc.dart';
import 'package:marketplace/presentation/offers_page.dart';

void main() => runApp(MyApp());

final offersRepo = OffersRepository(client.value);
final offersBloc = OffersBloc(offersRepo);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: CustomerOffersPage(title: 'Marketplace'),
    );
  }
}
