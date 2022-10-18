import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionListItem(
      {Key key, @required this.transaction, @required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: FittedBox(
              child: Text(
                '€${transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          icon: Platform.isIOS
              ? Icon(CupertinoIcons.delete_solid)
              : Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error,
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}
