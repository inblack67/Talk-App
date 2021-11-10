import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String message;
  final String okTitle;

  const CustomAlert(
      {Key? key,
      required this.title,
      required this.message,
      this.okTitle = 'Ok'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.red[900],
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(okTitle),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => Colors.red[900],
            ),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) => Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
