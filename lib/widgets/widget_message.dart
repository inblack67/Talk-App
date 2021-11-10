import 'package:flutter/material.dart';

class WMessage extends StatelessWidget {
  final String username;
  final String content;
  final bool me;

  const WMessage(
      {Key? key,
      required this.username,
      required this.content,
      required this.me})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          color: me ? Colors.teal : Colors.red,
          borderRadius: BorderRadius.circular(10.0),
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(' ~ $username'),
      ],
    );
  }
}
