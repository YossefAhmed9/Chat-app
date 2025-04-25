import 'package:chat_app/Layouts/Register%20Screen.dart';
import 'package:chat_app/Layouts/chat%20screen.dart';
import 'package:chat_app/Layouts/splash_screen.dart';
import 'package:chat_app/users%20screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Layouts/login_screen.dart';
import 'cache/shared_prefrence.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 CacheHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage': (context) => LoginScreen(),
        'RegisterPage': (context) => RegisterScreen(),
        'ChatScreen': (context) => ChatScreen(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,fontFamily: 'poppins',iconTheme: IconThemeData(color: Colors.teal)
      ),
      home: SplashScreen(),
    );
  }
}
