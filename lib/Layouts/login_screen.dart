import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class Login_Screen extends StatefulWidget {
  Login_Screen({super.key});

  String id = 'LoginPage';

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var emailcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormState>();
  var passcontroller = TextEditingController();
  bool showpass = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
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
                    emailcontroller.text = value!;
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
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passcontroller.text);
                        Navigator.pushNamed(context, 'ChatScreen',
                            arguments: emailcontroller.text);
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
                    color: Colors.blue,
                    child: isLoading == true
                        ? const CircularProgressIndicator()
                        : const Text(
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
                // defaultButton(double.infinity, 50.0, Colors.red, () {
                //   print('heeeeelo');
                // }, 'Register', Colors.white, 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
