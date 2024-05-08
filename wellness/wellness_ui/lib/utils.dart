import 'package:flutter/material.dart';

class Utils extends StatefulWidget {
  const Utils({super.key});

  @override
  State<Utils> createState() => _Utils();
}

class _Utils extends State<Utils> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

   void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
