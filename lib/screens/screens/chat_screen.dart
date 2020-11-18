import 'package:dt_front/components/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert' as convert;

class ChatScreen extends StatelessWidget {
  Map args;
  static String id = 'chat_screen';

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    int room = args['room'] ?? 1;
    String fistName = args['first_name'] ?? 'first';
    String lastName = args['last_name'] ?? 'last';
    int sender_id = args['sender_id'];
    final title = fistName + ' ' + lastName;
    return MyHomePage(
      title: title,
      channel: IOWebSocketChannel.connect(
          'ws://192.168.43.126:8000/api/chat/$room/'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;
  final String username = 'admin';

  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    get_data();
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    List list;
    int count = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data);
                    final result = convert.jsonDecode(snapshot.data);
                    if (result['command'] == 'new_message') {
                      count++;
                      // print(result['message']['content']);

                      list.insert(
                        0,
                        MessageBubble(
                          timestamp: result['message']['timestamp'],
                          text: result['message']['content'],
                          isMe: true,
                        ),
                      );
                    } else {
                      list = [];
                      count = 0;
                      final result = convert.jsonDecode(snapshot.data);
                      // print(result);
                      for (var each_message in result['messages']) {
                        count++;
                        // print(each_message['content']);
                        // print("*"+each_message['sender']+"*");
                        list.add(
                          MessageBubble(
                            timestamp: each_message['timestamp'],
                            text: each_message['content'],
                            isMe: (widget.username == each_message['sender']) ? true : false,
                          ),
                        );
                      }
                    }
                    // return Container();
                    return ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return list[index];
                      },
                      itemCount: count,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[200]),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.purple.shade300,
                    ),
                    onPressed: () {
                      _sendMessage();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(convert.jsonEncode({
        'message': _controller.text,
        'command': 'new_message',
        'sender': 2,
        'room_id': 2,
      }));
      _controller.text = '';
    }
  }

  get_data() {
    widget.channel.sink.add(convert.jsonEncode({
      'command': 'fetch_messages',
      'room_id': 2,
    }));
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    print('**************************');
    print(DateTime.now());
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
