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

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Chat Screen'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            // print(snapshot.data?['message']);
            List<Message> data = [];
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                data.add(Message.fromJson(snapshot.data!.docs[i]));
              }

              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            if (data[index].id == email) {
                              return ChatBubble(index, data);
                            } else {
                              return SenderChatBubble(index, data);
                            }
                          }),
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
                                'createdAt': DateTime.now(),
                                'id': email // John Doe
                              }).then((value) {
                                print('email is $email 🎎🎎🎎🎎🎎🎎🎎🎎🎎🎎');
                                chatController.clear();
                                scrollController.animateTo(
                                    scrollController.position.minScrollExtent,
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
                                    'createdAt': DateTime.now(),
                                    'id': email // John Doe
                                  }).then((value) {
                                    print(
                                        'email is $email 🎎🎎🎎🎎🎎🎎🎎🎎🎎🎎');
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
