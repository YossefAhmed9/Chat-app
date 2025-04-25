import 'package:flutter/material.dart';

import '../cache/cashe_keys.dart';
import '../cache/shared_prefrence.dart';
import 'Home Screen.dart';
import 'Register Screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  @override
  void initState() {
    super.initState();

    _startAnimationsAndNavigate();
  }

  void _startAnimationsAndNavigate() async {
    // Trigger the opacity animation after a short delay
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _opacity = 1.0;
    });

    await Future.delayed(const Duration(seconds: 1));

    final isLoggedIn = CacheHelper.getBoolean(key: CacheKeys.loginDone) == true;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (CacheHelper.getBoolean(key: CacheKeys.loginDone) == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.teal.shade400),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200 ),
            opacity: _opacity,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Text(
                'Social app',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 5,
                  fontFamily: 'poppins',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
