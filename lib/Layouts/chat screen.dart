import 'package:chat_app/components/components.dart';
import 'package:chat_app/models/message%20model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chatKey = GlobalKey<FormState>();

  TextEditingController chatController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ScrollController scrollController = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Query<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('messages').orderBy("asc");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Chat Screen'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy('createdAt').snapshots(),
          builder: (context, snapshot) {
            // print(snapshot.data?['message']);
            List<dynamic> data = [];
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                data.add(Message.fromJson(snapshot.data!.docs[i]));
              }

              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                  left: 8.0,
                                  right: 55.0,
                                  top: 8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    '${data[index].message}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                    softWrap: true,
                                    maxLines: 5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                              chatKey, TextInputType.text, chatController,
                              (value) {
                            setState(() {
                              messages.add({
                                'message': chatController.text,
                                'createdAt': DateTime.now() // John Doe
                              }).then((value) {
                                chatController.clear();
                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 1),
                                    curve: Curves.fastEaseInToSlowEaseOut);
                              });
                            });
                          },
                              (p0) => null,
                              () {},
                              'Type your message...',
                              InputBorder.none,
                              const Icon(Icons.message_outlined),
                              (value) => null),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  messages.add({
                                    'message': chatController.text,
                                    'createdAt': DateTime.now() // John Doe
                                  }).then((value) {
                                    chatController.clear();
                                    scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration: Duration(milliseconds: 1),
                                        curve: Curves.fastEaseInToSlowEaseOut);
                                  });
                                });
                              },
                              icon: const Icon(Icons.send_rounded)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              );
            }
          }),
    );
  }
}
