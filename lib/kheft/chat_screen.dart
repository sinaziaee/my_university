import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_university/components/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert' as convert;

import '../constants.dart';

int room, currentUserId;
String myUsername, otherUsername;

class ChatScreen extends StatelessWidget {
  Map args;
  static String id = 'chat_screen';

  String firstName, lastName, image;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    room = args['room'];
    // firstName = args['first_name'] ?? 'first';
    // lastName = args['last_name'] ?? 'last';
    myUsername = args['username'];
    currentUserId = args['user_id'];
    otherUsername = args['other_username'];
    image = args['image'];
    print('room: $room');
    print('username: $myUsername');
    final title = otherUsername;
    // getData();
    // return Scaffold();
    return MyHomePage(
      title: 'گفتگو با $title',
      channel:
          IOWebSocketChannel.connect('ws://172.17.3.157:5000/ws/chat/$room/'),
      image: image,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final String image;
  final WebSocketChannel channel;
  final int currentUserId;

  // final String username = 'admin';

  MyHomePage(
      {Key key,
      @required this.title,
      @required this.channel,
        @required this.image,
      this.currentUserId})
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
      backgroundColor: Color(0xfffff8ee),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 5, top: 2, bottom: 2),
          child: CircleAvatar(
            // backgroundImage: NetworkImage(avatars[0]),
            backgroundColor: Colors.white,
            backgroundImage: (widget.image != null && widget.image.length != 0)
                ? NetworkImage(
                    '$baseUrl${widget.image}',
                  )
                : AssetImage('assets/images/unkown.png'),
          ),
        ),
        backgroundColor: Colors.purple.shade300,
        title: Text(
          widget.title,
          textDirection: TextDirection.rtl,
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
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
                    // print(result);
                    if (result['command'] == 'new_message') {
                      count++;
                      // print(result['message']['content']);
                      print(result['message']['sender']);
                      if (myUsername == result['message']['sender']) {
                        list.insert(
                          0,
                          MessageBubble(
                            timestamp: result['message']['timestamp'],
                            text: result['message']['content'],
                            isMe: true,
                          ),
                        );
                      } else {
                        list.insert(
                          0,
                          MessageBubble(
                            timestamp: result['message']['timestamp'],
                            text: result['message']['content'],
                            isMe: false,
                          ),
                        );
                      }
                    } else {
                      list = [];
                      count = 0;
                      final result = convert.jsonDecode(snapshot.data);
                      // print(result);
                      for (var each_message in result['messages']) {
                        count++;
                        // print(each_message['content']);
                        // print("*"+each_message['sender']+"*");
                        // print(each_message['sender']);
                        // print('*$username* + *${each_message['sender']}*');
                        // (username.toString() == result['sender'].toString()) ? print(true): print(false);
                        if (myUsername == each_message['sender']) {
                          list.add(
                            MessageBubble(
                              timestamp: each_message['timestamp'],
                              text: each_message['content'],
                              isMe: true,
                            ),
                          );
                        } else {
                          list.add(
                            MessageBubble(
                              timestamp: each_message['timestamp'],
                              text: each_message['content'],
                              isMe: false,
                            ),
                          );
                        }
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
                    child: SpinKitWave(
                      color: kPrimaryColor,
                    ),
                  );
                },
              ),
            ),
            // Container(
            //   height: 50,
            //   child: TextField(
            //     controller: _controller,
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.only(
            //         bottom: 25,
            //         left: 10,
            //         right: 10
            //       ),
            //       // suffix: IconButton(
            //       //   icon: Icon(
            //       //     Icons.send,
            //       //     size: 30,
            //       //     color: Colors.purple.shade300,
            //       //   ),
            //       //   onPressed: () {
            //       //     _sendMessage();
            //       //   },
            //       // ),
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10)),
            //     ),
            //   ),
            // ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(bottom: 25, left: 10, right: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    color: Colors.purple.shade300,
                    icon: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.white,
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
        'sender': myUsername,
        'room_id': room,
      }));
      _controller.text = '';
    }
  }

  get_data() {
    widget.channel.sink.add(convert.jsonEncode({
      'command': 'fetch_messages',
      'room_id': room,
    }));
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
