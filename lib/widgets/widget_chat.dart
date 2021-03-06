import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:talk/entities/message.dart';
import 'package:talk/utils/apis.dart';
import 'package:talk/utils/colors.dart';
import 'package:talk/utils/topics.dart';
import 'package:talk/widgets/custom_button.dart';
import 'package:talk/widgets/widget_dashboard.dart';
import 'package:talk/widgets/widget_message.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final String roomId;
  Chat({Key? key, required this.roomId}) : super(key: key);

  static const id = 'CHAT';

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late PhoenixSocket _socket;
  late FocusNode _focusNode;
  List<MMessage> _messages = [];
  PhoenixChannel? _channel;
  bool _websocketConnected = false;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController(keepScrollOffset: false);
  bool _scrollToEnd = false;

  Future<void> getMessages() async {
    try {
      var res =
          await http.get(Uri.parse(APIs.getMessagesOfRoomAPI(widget.roomId)));
      var resBody = jsonDecode(res.body);
      if (resBody['success']) {
        setState(() {
          _messages = (resBody['data'] as List)
              .map((el) => MMessage.fromJSON(el))
              .toList();
          _scrollToEnd = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void playChannels() async {
    _socket = PhoenixSocket(APIs.websocketAPI)..connect();
    _socket.closeStream.listen((event) {
      print('socket disconnected...');
      // setState(() {
      //   _websocketConnected = false;
      // });
      // showDialog(
      //   context: context,
      //   builder: (context) => const CustomAlert(
      //       title: 'Offline!', message: 'You have gone off the grid!'),
      // );
    });
    _socket.openStream.listen((event) {
      setState(() {
        print('socket connected...');
        _websocketConnected = true;
        _channel = _socket.addChannel(topic: 'room:${widget.roomId}');
        _channel?.join();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    getMessages();
    playChannels();
  }

  handlePostMessage() async {
    String messageContent = messageController.text;
    if (messageContent.isEmpty) {
      return;
    }
    _channel?.push(Topics.newMessage, {
      "payload": {"content": messageContent}
    });
    messageController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(((_) {
      if (_scrollToEnd) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    }));

    return Scaffold(
      backgroundColor: MyColors.primaryBG,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Dashboard.id);
              },
              icon: const Icon(Icons.close))
        ],
        title: Text('Talk | Chat',
            style: TextStyle(
              color: Colors.red[900],
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            )),
        backgroundColor: MyColors.primaryBG,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: _channel?.messages,
                  initialData: Message(
                    event: PhoenixChannelEvent.join,
                    joinRef: '',
                    payload: const {'times': 0},
                    ref: '',
                    topic: '',
                  ),
                  builder:
                      (BuildContext context, AsyncSnapshot<Message?> snapshot) {
                    if (snapshot.data?.payload?['data'] != null) {
                      var message =
                          MMessage.fromJSON(snapshot.data?.payload!['data']);
                      _messages.add(message);
                      SchedulerBinding.instance?.addPostFrameCallback((_) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        var el = _messages[index];
                        String messageContent = el.content;
                        String messageUsername = 'inblack67';
                        bool me = messageUsername == 'me';
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: WMessage(
                            username: messageUsername,
                            content: messageContent,
                            me: me,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    autofocus: true,
                    controller: messageController,
                    focusNode: _focusNode,
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
