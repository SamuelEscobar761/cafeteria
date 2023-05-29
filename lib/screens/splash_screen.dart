import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cafeteria/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //Future.delayed(Duration(milliseconds: 1500),()=> Navigator.push(context, MaterialPageRoute(()=> LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset("assets/images/logo.png"),
          SizedBox(height: 16.0),
          Text(
            'Bienvenido a Lalas Coffee!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 107, 142, 35),
            ),
          ),
        ],
      ),
      backgroundColor:  Colors.lightGreen.shade200,
      nextScreen: LoginScreen(),
      splashIconSize: 400,
      duration: 2500,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
