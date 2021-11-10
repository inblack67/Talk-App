import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      child: MaterialButton(
        color: Colors.red[900],
        onPressed: onPressed,
        child: Text(title),
        minWidth: 200.0,
        height: 50.0,
      ),
    );
  }
}
