import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: (Colors.red),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackbar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: (Colors.green),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
