import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SnackBarService {
  final GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  showErrorSnackBar(String errorMessage) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
  }

  showSuccessSnackBar(String text) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
  }
}
