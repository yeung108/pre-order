
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ConfirmAction { CANCEL, ACCEPT }
 
Future<ConfirmAction> ShowDialogConfirmButton(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: const Text(
            "You won't be able to revert this!"),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}