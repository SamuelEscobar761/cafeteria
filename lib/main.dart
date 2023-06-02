import 'package:cafeteria/screens/app_screens/acompanhamientos_screen.dart';
import 'package:cafeteria/screens/app_screens/menu_screen.dart';
import 'package:cafeteria/screens/app_screens/qr_screen.dart';
import 'package:cafeteria/screens/login_screen.dart';
import 'package:cafeteria/screens/register_screen.dart';
import 'package:cafeteria/screens/selection_screen.dart';
import 'package:cafeteria/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // Activa el modo de depuración para ver los registros de descarga
  );
  runApp(MyApp());
}


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
        '/qr': (context) => QRScreen()
      }
    );
  }
}