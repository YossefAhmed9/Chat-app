import 'package:chat_app/Layouts/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
    var confirmPassController = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var gendercontroller = TextEditingController();
  var userController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormState>();
  var nameKey = GlobalKey<FormState>();
  var phoneKey = GlobalKey<FormState>();
  var genderKey = GlobalKey<FormState>();
  var userKey = GlobalKey<FormState>();
  bool showpass = true;
  bool isLoading = false;
  String gender =' ';

  Future<UserCredential> register() async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailcontroller.text,
      password: passcontroller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register form'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Register Now!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 50.0,
                    ),
                  ),
                  const Text(
                    'Register now to connect with your friends',
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
                  const SizedBox(height: 15,),

                  defaultTextFormField(

                    controller: userController,
                    label: 'username',
                    key: userKey,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    change: (value){},
                    keyboard: TextInputType.text,
                    prefix: Icon(Icons.person),
                    submit: (value){

                    },
                    tap: (){},
                    validate:  (value) {
                      if (value!.isEmpty) {
                        return ('Password must be filled');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  //phone
                  defaultTextFormField(
                    key: phoneKey,
                    keyboard: TextInputType.number,
                    controller: phonecontroller,
                    submit: (value){},
                    change: (value){},
                    tap: (){},
                    label: 'Enter your phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    prefix: Icon(Icons.phone),
                    validate:  (value) {
                      if (value!.isEmpty) {
                        return ('phone must be filled');
                      }
                      return null;
                    },),
                  const SizedBox(
                    height: 20,
                  ),
                  //الكلية
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == ' ') {
                        return ('Select Gender');
                      }
                      return null;
                    },
                    value: gender,
                    items: [
                      ' ',
                      'male',
                      'female',
                    ]
                        .map((role) => DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Gender',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      prefixIcon: const Icon(Icons.list),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //pass
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
                    height: 15,
                  ),
                  //confirm pass
                  TextFormField(
                    controller: confirmPassController,
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
                      if (passcontroller.text != confirmPassController.text) {
                        return ('passwords don\'t match\ ');
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
                    height: 15,
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

                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>LoginScreen()));

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
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 5,
                          fontFamily: 'poppins'
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login Now!',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
