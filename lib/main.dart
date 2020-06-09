import 'package:flutter/material.dart';
import 'package:marketplace/graphql/client.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:marketplace/presentation/offers/offers_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

final _offersRepo = OffersRepository(client.value);
final offersBloc = AppBloc(_offersRepo);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppBloc>(
        create: (_) => offersBloc,
        child: MaterialApp(
          title: 'Marketplace',
          theme: ThemeData(
            primarySwatch: Colors.cyan,
            primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
          ),
          home: CustomerOffersPage(title: 'Marketplace'),
        ));
  }
}
