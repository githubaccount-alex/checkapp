import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String message;

  const ErrorComponent({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 60,
          color: Colors.pink[700],
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
