import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us',style: TextStyle(fontSize: 20),),centerTitle: true,),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('WhattsApp'),
              ],
            ),
            Row(
              children: [
                Text('Instagram'),
              ],
            ),
            Row(
              children: [
                Text('Phone'),
              ],
            ),
            Row(
              children: [
                Text('Facebook'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
