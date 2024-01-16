import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 60,
          color: Colors.pink[400],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
