import 'package:cafeteria/screens/app_screens/acompanhamientos_screen.dart';
import 'package:cafeteria/screens/app_screens/menu_screen.dart';
import 'package:cafeteria/screens/login_screen.dart';
import 'package:cafeteria/screens/register_screen.dart';
import 'package:cafeteria/screens/selection_screen.dart';
import 'package:cafeteria/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lalas Cafeteria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/selection': (context) => SelectionScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/menu': (context) => MenuScreen(),
      }
    );
  }
}