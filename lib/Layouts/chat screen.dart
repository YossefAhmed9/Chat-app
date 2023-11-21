import 'package:chat_app/components/components.dart';
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

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Chat Screen'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: messages.get(),
          builder: (context, snapshot) {
            data.add(snapshot.data?.docs[1]['message']);
            // print(snapshot.data?['message']);
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 15,
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
                                    '${data[1]}',
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
                                'message': chatController.text, // John Doe
                              }).then((value) {
                                chatController.clear();
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
                                    'message': chatController.text, // John Doe
                                  }).then((value) {
                                    setState(() {
                                      chatController.clear();
                                    });
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
