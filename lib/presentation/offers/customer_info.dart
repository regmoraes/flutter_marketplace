import 'package:flutter/material.dart';
import 'package:marketplace/model/customer.dart';
import 'package:marketplace/presentation/app_bloc.dart';
import 'package:provider/provider.dart';

class CustomerInfo extends StatelessWidget {
  final Customer customer;

  CustomerInfo(this.customer);

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.cyan,
      child: ListTile(
        title: Text("Hi, ${customer.name}", style: _customerInfoTextStyle),
        subtitle: StreamBuilder(
          stream: appBloc.customerBalanceStream,
          initialData: customer.balance,
          builder: (context, snapshot) {
            final customerBalance =
                snapshot.hasData ? snapshot.data : customer.balance;

            return Text(
              "\$ $customerBalance",
              style: _customerInfoTextStyle,
              textAlign: TextAlign.end,
            );
          },
        ),
      ),
    );
  }
}

const _customerInfoTextStyle =
    TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold);
