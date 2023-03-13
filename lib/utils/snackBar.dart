import '../../utils/globals.dart';
import 'package:flutter/material.dart';

void customSnackBar(String content) {
  snackbarKey.currentState?.showSnackBar(SnackBar(
    content: Text(
      content,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.black,
  ));
}
