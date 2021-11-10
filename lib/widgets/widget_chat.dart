import 'package:flutter/material.dart';
import 'package:talk/utils/chat_arguments.dart';
import 'package:talk/widgets/custom_button.dart';
import 'package:talk/widgets/widget_dashboard.dart';
import 'package:talk/widgets/widget_message.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  static const id = 'CHAT';

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late String roomId;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController(keepScrollOffset: false);

  handlePostMessage() async {
    String messageContent = messageController.text;
    if (messageContent.isEmpty) {
      return;
    }
    print('messageContent $messageContent');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatArguments?;

    if (args == null) {
      Navigator.of(context).pushNamed(Dashboard.id);
    }

    setState(() {
      roomId = args!.roomId!;
    });

    final data = [];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('FElixir | Chat',
            style: TextStyle(
              color: Colors.red[900],
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            )),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                controller: scrollController,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var el = data[index];
                  String messageContent = el['content'];
                  String messageUsername = 'inblack67';
                  bool me = messageUsername == el['user']['username'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WMessage(
                      username: messageUsername,
                      content: messageContent,
                      me: me,
                    ),
                  );
                  // return ListTile(
                  //   title: Text(messageContent),
                  // );
                },
              )),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: messageController,
                    decoration:
                        const InputDecoration(hintText: 'Start typing...'),
                  )),
                  CustomButton(title: 'Send', onPressed: handlePostMessage),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
