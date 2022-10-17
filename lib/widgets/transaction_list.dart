import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(
      {@required this.transactions, @required this.deleteTransaction});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: widget.transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'You havent added any expenses yet!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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
          : ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (direction) {
                    widget.deleteTransaction(index);
                  },
                  child: Card(
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
                              '\$${widget.transactions[index].amount}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        widget.transactions[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(widget.transactions[index].date),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.transactions.length,
            ),
    );
  }
}
