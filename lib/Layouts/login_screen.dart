
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../cache/cashe_keys.dart';
import '../cache/shared_prefrence.dart';
import '../components/components.dart';
import 'Home Screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  String id = 'LoginPage';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormState>();
  var passcontroller = TextEditingController();
  bool showpass = true;
  //bool isLoading = false;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Login Now!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 50.0,
                    ),
                  ),
                  const Text(
                    'Login now to connect with your friends',
                    style: TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  defaultTextFormField(
                   key:  emailKey,
                    keyboard:  TextInputType.emailAddress,
                   controller:  emailcontroller,
                   change:  (value) {
                      emailcontroller.text = value!;
                    },
                   submit:  (value) {
                      print(value);
                    },
                   tap:  () {},
                   label:  'Email',
                  border:  OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
                   prefix:  const Icon(
                      Icons.email_rounded,
                    ),
                   validate:  (value) {
                      if (value!.isEmpty) {
                        return ('Email must be filled');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    obscureText: showpass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Password must be filled');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border:  OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showpass = !showpass;
                            });
                          },
                          child: const Icon(Icons.remove_red_eye_outlined)),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,borderRadius: BorderRadius.circular(25),
                    ),
                    width: double.infinity,
                    height: 55.0,
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          print('email: ' + emailcontroller.text);
                          print('pass: ' + passcontroller.text);
                        }
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailcontroller.text,
                              password: passcontroller.text).then((value){
                                setState(() {
                                  CacheHelper.setBoolean(key: CacheKeys.loginDone, value: true);
                                  CacheHelper.setBoolean(key: CacheKeys.email, value: emailcontroller.text);
                                  print('333333333333333333');
                                  print('entered set state');
                                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>HomeScreen()));

                                });
                                // Navigator.pushNamed(context, 'ChatScreen',
                                //     arguments: emailcontroller.text);
                          });



                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, 'No user found for that email.',
                                5, Colors.red);
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                                context,
                                'Wrong password provided for that user.',
                                5,
                                Colors.red);
                          }
                        }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'RegisterPage');
                        },
                        child: const Text(
                          'Register Now!',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.teal.shade600),
                      child: MaterialButton(onPressed: (){
                        signInWithGoogle().then((value){
                          Navigator.pushNamed(context, 'ChatScreen',arguments: emailcontroller.text);
                          if (kDebugMode) {
                            print('########################################################');
                            print(value);
                            print(value.credential);
                            print(value.additionalUserInfo);
                            print(value.user);
                            print('########################################################');
                          }
                        });
                      },
                        child: Text('Sign in with google account',style: TextStyle(color: Colors.white),),),
                    ),
                  ),
                  Text('Emails'),
                  Text('yossefahmed209@gmail.com'),
                  Text('yabdullah@student.eelu.edu.eg'),
                  Text('pass for both'),
                  Text('123456789'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
