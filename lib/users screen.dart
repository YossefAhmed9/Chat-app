
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    List usersList=[];
    return Scaffold(
      appBar: AppBar(
        title: Text('User\'s screen',style: TextStyle(fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 150,
                height: 150,
                child: MaterialButton(onPressed: () async {
                 try{

                   usersList.add(users.doc("first user").collection("first user's messages").get());
                   print(await usersList);
                 }
                     catch(error){
                   print('this is th type ${error.runtimeType}');
                   print('this is the error ${error.toString()}');
                     }

                },child: Text('press'),),
              )
            ],
          );
        }
      ),
    );
  }
}
