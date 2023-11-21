import 'package:chat_app/components/components.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  var chatKey = GlobalKey<FormState>();
  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text('Chat Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
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
                          bottom: 8.0, left: 8.0, right: 55.0, top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Hello, I\'m a new user ,',
                            style: TextStyle(fontSize: 15, color: Colors.white),
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
                      chatKey,
                      TextInputType.text,
                      chatController,
                      (p0) => null,
                      (p0) => null,
                      () {},
                      'Type your message...',
                      InputBorder.none,
                      Icon(Icons.message_outlined),
                      (value) => null),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.send_rounded)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
