import 'package:flutter/material.dart';

purchaseAlert(
    BuildContext context, String title, String message, Function() callback) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                if (callback != null) callback();
              },
            )
          ],
        ),
      );
    },
  );
}
