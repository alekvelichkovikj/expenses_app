import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({@required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final _enteredTitle = _titleControler.text;
    var _enteredAmount = _amountControler.text;

    if (_enteredAmount.contains(',')) {
      _enteredAmount = _enteredAmount.replaceFirst(RegExp(','), '.');
    }

    if (_enteredTitle.isEmpty ||
        _enteredAmount.isEmpty ||
        _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
      _enteredTitle,
      double.parse(_enteredAmount),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitData(),
                controller: _titleControler,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
                controller: _amountControler,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    AdaptiveFlatButton(
                      pressHandler: _presentDatePicker,
                      textValue: 'Choose Date',
                    )
                  ],
                ),
              ),
              Platform.isIOS
                  ? Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: CupertinoButton(
                        color: Theme.of(context).colorScheme.primary,
                        child: Text(
                          'Add transaction',
                        ),
                        onPressed: _submitData,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _submitData,
                      child: Text(
                        'Add transaction',
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
