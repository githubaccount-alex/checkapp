import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String inputText;
  final void Function() callback;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.inputText,
    required this.callback,
    required this.backgroundColor,
    required this.textColor,
    required this.width,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(width, height),
        ),
      ),
      child: Center(
        child: Text(
          inputText,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
