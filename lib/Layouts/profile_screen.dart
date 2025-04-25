import 'package:chat_app/Layouts/contact_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: FloatingActionButton.extended(onPressed: () { navigateTo(context, UpdateProfile()); }, label: Text('Update your profile',style: TextStyle(fontSize: 17),), ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(150)),clipBehavior: Clip.antiAliasWithSaveLayer,
              //Image from firebase
              child: Image.network(
                  'AccountData.fromJson(cubit.getResult).profileImage}',width: 170,height: 170,
                  errorBuilder: (BuildContext context,
                      Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset('assets/images/error image.png',width: 50,height: 50,);

                  }
              ),
            ),
            Text('Name: Name from firebase',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Text('Email: email from firebase',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Text('National ID: email from firebase',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Text('Gender: email from firebase',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Text('Phone: email from firebase',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            SizedBox(height: 50,),
            TextButton(onPressed: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context)=> ContactUs()));

            }, child: Text('Contact Us!',style: TextStyle(fontFamily: 'urbanist',fontSize: 25,fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),)),
          ],
        ),
      ),
    );
  }
}
