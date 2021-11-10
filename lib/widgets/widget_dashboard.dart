import 'package:flutter/material.dart';
import 'package:talk/utils/chat_arguments.dart';
import 'package:talk/widgets/widget_chat.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  static const id = 'DASHBOARD';

  @override
  Widget build(BuildContext context) {
    final data = [];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('FElixir | Rooms',
            style: TextStyle(
              color: Colors.red[900],
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            )),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var el = data[index];
          return ListTile(
            // leading: Text('   ' + el.name!),
            title: Text(el['name']),
            trailing: Text(el['user']['username']),
            onTap: () {
              print('room with id ${el['id']} tapped');
              Navigator.of(context).pushNamed(Chat.id,
                  arguments: ChatArguments(roomId: el['id']));
            },
          );
        },
      ),
    );
  }
}
