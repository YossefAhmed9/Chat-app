import 'package:chat_app/Layouts/contact_us.dart';
import 'package:chat_app/Layouts/favorites_view.dart';
import 'package:chat_app/Layouts/notification_view.dart';
import 'package:chat_app/Layouts/profile_screen.dart';
import 'package:chat_app/Layouts/videos_view.dart';
import 'package:chat_app/cache/cashe_keys.dart';
import 'package:chat_app/cache/shared_prefrence.dart';
import 'package:chat_app/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'images_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleKey = GlobalKey<FormState>();
  var bodyKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(builder: (context) {
        return Container(
          width: 120,
          child: FloatingActionButton(
              isExtended: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  Text('Add post'),
                ],
              ),
              onPressed: () {
                Scaffold.of(context).showBottomSheet(
                  enableDrag: true,
                  showDragHandle: true,
                  backgroundColor: Colors.teal.shade200,
                  (context) {
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: Column(
                        children: [
                          Center(
                            child: Text('Add post'),
                          ),
                          //title
                          defaultTextFormField(
                            key: titleKey,
                            keyboard: TextInputType.text,
                            controller: titleController,
                           submit:  (value) {},
                            change: (value) {},
                            tap: () {},
                            label: 'Enter title',
                           border:  OutlineInputBorder(),
                            prefix: Icon(Icons.view_headline),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ('Enter the title');
                              }
                              return null;
                            },
                          ),
                          //body
                          defaultTextFormField(
                            key: bodyKey,
                            keyboard: TextInputType.text,
                            controller: bodyController,
                            submit: (value) {},
                            change: (value) {},
                            tap: () {},
                            label: 'Enter title',
                           border:  OutlineInputBorder(),
                            prefix: Icon(Icons.view_headline),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ('Enter the title');
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
        );
      }),
      drawer: Drawer(
        elevation: 0,
        shadowColor: Colors.red,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        size: 40,
                      ),
                      Text('  Home')
                    ],
                  ),
                  onTap: () {
                    Navigator.pop;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                      ),
                      Text('  Profile')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 40,
                      ),
                      Text('  Notification')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => NotificationView()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 40,
                      ),
                      Text('  Favorite')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => FavoritesView()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        size: 40,
                      ),
                      Text('  Images')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ImagesScreen()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.video_camera_back_outlined,
                        size: 40,
                      ),
                      Text('  videos')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => VideosView()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.contact_mail,
                        size: 40,
                      ),
                      Text('  contact us')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => ContactUs()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(Icons.person),
          ),
        ],
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade400),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'title : fasfasasfafasfasfsafasfsaawsdfasfasdfasfasfasfa'),
                      Text('body: prighwrpignpiknerggergikon'),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
