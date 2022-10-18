import 'dart:io';
import 'package:expenses_app/widgets/transaction_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({
    @required this.transactions,
    @required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'You havent added any expenses yet!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : Container(
            padding: Platform.isIOS ? EdgeInsets.only(bottom: 40) : null,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TransactionListItem(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction,
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}
