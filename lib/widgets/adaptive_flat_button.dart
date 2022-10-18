import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final Function pressHandler;
  final String textValue;

  AdaptiveFlatButton({@required this.pressHandler, @required this.textValue});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              textValue,
              style: TextStyle(fontSize: 16),
            ),
            onPressed: pressHandler,
          )
        : TextButton(
            onPressed: pressHandler,
            child: Text(
              textValue,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
