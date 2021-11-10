import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:talk/entities/room.dart';
import 'package:talk/utils/apis.dart';
import 'package:talk/utils/chat_arguments.dart';
import 'package:talk/widgets/widget_chat.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const id = 'DASHBOARD';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<MRoom> _rooms = [];

  Future<void> getRooms() async {
    try {
      var res = await http.get(Uri.parse(APIs.getRoomsAPI));
      var resBody = jsonDecode(res.body);
      if (resBody['success']) {
        // print(resBody['data']);
        setState(() {
          _rooms = (resBody['data'] as List)
              .map((el) => MRoom.fromJSON(el))
              .toList();
          ;
        });
      }
      print(resBody);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          var el = _rooms[index];
          return ListTile(
            title: Text(el.name),
            onTap: () {
              print('room with id ${el.id} tapped');
              Navigator.of(context).pushNamed(
                Chat.id,
                arguments: ChatArguments(roomId: el.id.toString()),
              );
            },
          );
        },
      ),
    );
  }
}

// class Dashboard extends StatelessWidget {
//   const Dashboard({Key? key}) : super(key: key);
//   static const id = 'DASHBOARD';


// }
