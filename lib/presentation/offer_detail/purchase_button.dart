import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../states.dart';

class PurchaseButton extends StatelessWidget {
  final PurchaseState purchaseState;
  final void Function() onPressed;

  PurchaseButton(this.purchaseState, [this.onPressed]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      child: SizedBox(
        width: 300,
        height: 50,
        child: RaisedButton(
          color: Colors.cyan,
          textColor: Colors.white,
          onPressed: () => onPressed?.call(),
          child: purchaseState.purchasing
              ? const CircularProgressIndicator(backgroundColor: Colors.white)
              : const Text("Purchase"),
        ),
      ),
    );
  }
}
