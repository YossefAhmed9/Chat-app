import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/components.dart';

class Register_Screen extends StatefulWidget {
  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  var emailcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormState>();
  bool showpass = true;
  bool isLoading = false;
  var passcontroller = TextEditingController();

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
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 50.0,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  defaultTextFormField(
                    emailKey,
                    TextInputType.emailAddress,
                    emailcontroller,
                    (value) {
                      print(value);
                    },
                    (value) {
                      print(value);
                    },
                    () {},
                    'Email',
                    const OutlineInputBorder(),
                    const Icon(
                      Icons.email_rounded,
                    ),
                    (value) {
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
                      border: const OutlineInputBorder(),
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
                  SizedBox(
                    width: double.infinity,
                    height: 55.0,
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          print('email: ' + emailcontroller.text);
                          print('pass: ' + passcontroller.text);
                        }
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          register().then((value) {
                            showSnackBar(context, 'Email created successfully',
                                5, Colors.teal);
                            setState(() {
                              isLoading = false;
                            });
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context,
                                'The password provided is too weak.',
                                5,
                                Colors.red);
                          } else if (e.code == 'email-already-in-use') {
                            setState(() {
                              isLoading = false;
                            });
                            showSnackBar(
                                context,
                                'E-mail already in use, Go to login page and try to login with your account',
                                5,
                                Colors.deepPurpleAccent);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      color: Colors.blue,
                      child: isLoading == true
                          ? CircularProgressIndicator()
                          : Text(
                              'Register',
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
                        'Already have an account?',
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
                  // defaultButton(double.infinity, 50.0, Colors.red, () {
                  //   print('heeeeelo');
                  // }, 'Register', Colors.white, 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
