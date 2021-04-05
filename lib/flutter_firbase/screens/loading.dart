import 'package:flutter/material.dart';

loading(context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    },
  );
}
